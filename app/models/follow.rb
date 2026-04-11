class Follow < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  validates :follower_id, uniqueness: { scope: :followed_id }
  validate :cannot_follow_self

  def cannot_follow_self
    errors.add(:base, "Cannot follow yourself") if follower_id == followed_id
  end
end
