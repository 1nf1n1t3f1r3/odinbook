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

  # Our algorithmic scope that balances global trends with personal follow networks
  scope :by_hotness_for, ->(user) {
    # Fallback to [0] if not logged in or following no one so the SQL check doesn't crash
    following_list = user&.following_ids&.any? ? user.following_ids : [ 0 ]

    # Friend multiplier: 10x boost if you follow them
    multiplier_sql = "
      CASE
        WHEN posts.user_id IN (#{following_list.join(',')}) THEN 10
        ELSE 1.0
      end
    "

    # Algorithmic calculation: (Engagement / Time Decay) * Follow Multiplier
    formula = "
      ((posts.likes_count + posts.comments_count * 2 + 1) /
      ((EXTRACT(EPOCH FROM (NOW() - posts.created_at)) / 3600) + 12)) * #{multiplier_sql}
    "

    select("posts.*, #{formula} AS hot_score")
      .order(Arel.sql("#{formula} DESC"))
  }
end
