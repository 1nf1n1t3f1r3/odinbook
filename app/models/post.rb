class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true
  # Later: Comments, Likes
end
