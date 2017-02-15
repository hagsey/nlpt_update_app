class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :updates
  default_scope -> { order(first_name: :asc) }

  before_save :downcase_email

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  def full_name
    self.first_name + " " + self.last_name
  end

  def downcase_email
    email.downcase!
  end
end
