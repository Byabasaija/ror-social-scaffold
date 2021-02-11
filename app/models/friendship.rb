# We used https://collectiveidea.com/blog/archives/2015/07/30/bi-directional-and-self-referential-associations-in-rails
# article to create a bidirectional realtionship of friendship with user.
class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_create :create_inverse, unless: :inverse_friendship?

  def create_inverse
    self.class.create(inverse_friendship_options)
  end

  def inverse_friendship?
    self.class.exists?(inverse_friendship_options)
  end

  def inverse_friendship_options
    { friend_id: user_id, user_id: friend_id }
  end
end
