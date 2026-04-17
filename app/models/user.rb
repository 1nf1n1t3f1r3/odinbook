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

  has_many :following_relationships,
          class_name: "Follow",
          foreign_key: "follower_id",
          dependent: :destroy

  has_many :following,
          through: :following_relationships,
          source: :followed

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

  private

  def send_welcome_email
    Rails.logger.info "🔥 CALLBACK TRIGGERED: sending welcome email"
    UserMailer.welcome_email(self)
  end
end
