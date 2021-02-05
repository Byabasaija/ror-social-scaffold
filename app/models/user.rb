class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friend_id

  def friends
    friend_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friend_array + inverse_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friend_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend if !friendship.confirmed }.compact
  end

  def friend_requests
    friendships.map { |friendship| friendship.user if !friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |friendship| friendship.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def friends?(user)
    friends.include?(user)
  end

  def pending_friends?(user)
    pending_friends.include?(user)
  end
end
