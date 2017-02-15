class Update < ApplicationRecord
  belongs_to :user
  belongs_to :client

  default_scope -> { order(created_at: :desc) }

  validates :date, presence: true
  
  def coach
    self.user.full_name
  end
end
