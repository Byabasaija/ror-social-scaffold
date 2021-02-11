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
  has_many :friends, through: :friendships
  has_many :friend_requests_as_sender, foreign_key: :sender_id, class_name: 'FriendRequest'
  has_many :friend_requests_as_receiver, foreign_key: :receiver_id, class_name: 'FriendRequest'

  def confirm_friend(user)
    self.friends << user
  end

  def friend_requests?(user)
    self.friend_requests_as_receiver.find_by(sender:user) || self.friend_requests_as_sender.find_by(receiver:user)
  end
  def friends?(user)
    friends.include?(user)
  end
end
