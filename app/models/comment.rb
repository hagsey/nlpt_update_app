class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  # default_scope -> { order(created_at: :desc) }

  validates :body, length: {maximum: 100_000}
end
