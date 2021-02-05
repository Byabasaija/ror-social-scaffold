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
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: :friend_id

  def friends
    friend_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friend_array.concat(inverse_friendships.map { |friendship| friendship.user if friendship.confirmed })
    friend_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_requests
    friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact
  end

  def confirm_friend(user)
    friendship = friendships.find { |friends| friends.friend == user }
    friendship.confirmed = true
    friendship.save
  end

  def reject_friend(user)
    friendship = friendships.find { |friends| friends.friend == user }
    friendship.destroy
  end

  def request_received
    friendships.map(&:friend)
  end

  def request_sent
    inverse_friendships.map(&:user)
  end

  def request_sent?(user)
    request_sent.include?(user)
  end

  def request_received?(user)
    request_received.include?(user)
  end

  def friends?(user)
    friends.include?(user)
  end
end
