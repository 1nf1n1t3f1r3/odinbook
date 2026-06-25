class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_commit :send_welcome_email, on: :create

  has_one_attached :avatar

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  # Outbound relationships (People you follow)
  has_many :following_relationships,
          class_name: "Follow",
          foreign_key: "follower_id",
          dependent: :destroy

  has_many :following,
          through: :following_relationships,
          source: :followed

  # Inbound relationships (People following you)
  has_many :follower_relationships,
         class_name: "Follow",
         foreign_key: "followed_id",
         dependent: :destroy

  has_many :followers,
         through: :follower_relationships,
         source: :follower

  def following?(user)
    return false unless user
    following.exists?(user.id)
  end

  # --- ALGORITHMIC SUGGESTIONS ENGINE ---
  def self.suggested_for(current_user, search_query = nil)
    return all if current_user.nil?

    # 1. Base Scope: Exclude the logged-in user themselves
    scope = where.not(id: current_user.id)

    # 2. Text Search: Apply fuzzy match filtration if a query is present
    if search_query.present?
      scope = scope.where("username LIKE ?", "%#{search_query}%")
    end

    # 3. Dynamic Matrix Computation via SQL Subqueries
    scope.select("users.*", "
      (
        /* MUTUAL FOLLOWS: Check if this user is actively following current_user back (+5 pts) */
        (SELECT COUNT(*) FROM follows WHERE follows.follower_id = users.id AND follows.followed_id = #{current_user.id}) * 5
      ) + (
        /* LIKE ENGAGEMENT: Cumulative likes between current_user and this user (+2 pts per hit) */
        (SELECT COUNT(*) FROM likes INNER JOIN posts ON posts.id = likes.post_id WHERE posts.user_id = users.id AND likes.user_id = #{current_user.id}) * 2 +
        (SELECT COUNT(*) FROM likes INNER JOIN posts ON posts.id = likes.post_id WHERE posts.user_id = #{current_user.id} AND likes.user_id = users.id) * 2
      ) + (
        /* MUTUAL CONNECTIONS: Count shared accounts that BOTH current_user and this user follow (+3 pts per match) */
        SELECT COUNT(*) FROM follows f1
        INNER JOIN follows f2 ON f1.followed_id = f2.followed_id
        WHERE f1.follower_id = #{current_user.id} AND f2.follower_id = users.id
      ) * 3 AS connection_score")
      .order("connection_score DESC, username ASC")
  end

  private

  def send_welcome_email
    Rails.logger.info "🔥 CALLBACK TRIGGERED: sending welcome email"
    UserMailer.welcome_email(self)
  end
end
