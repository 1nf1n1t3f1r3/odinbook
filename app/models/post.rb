class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true
    has_many :comments, dependent: :destroy
    # Later: Comments, Likes
    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user

  def liked_by?(user)
    likes.exists?(user: user)
  end

  def self.feed_for(user)
    where(user_id: user.following_ids + [ user.id ])
      .order(created_at: :desc)
  end
end
