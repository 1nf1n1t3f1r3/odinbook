class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user

  has_one_attached :image

  # Functions
  def liked_by?(user)
    likes.exists?(user: user)
  end

  def self.feed_for(user)
    where(user_id: user.following_ids + [ user.id ])
  end

  # Scopes
  scope :with_hot_score, -> {
    select("
      posts.*,
      (likes_count + comments_count * 2 + 1) /
      ((EXTRACT(EPOCH FROM (NOW() - created_at)) / 3600) + 12)
      AS hot_score
    ")
  }

  scope :hot_ordered, -> {
    order("hot_score DESC")
  }
end
