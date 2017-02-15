class Client < ApplicationRecord
  has_many :updates

  before_save :strip_names

  default_scope -> { order(first_name: :asc) }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validate :birth_date_can_not_be_in_future
  # validate :full_name_must_be_unique
  mount_uploader :profile_image, ProfileImageUploader
  validate :profile_image_size


  def birth_date_can_not_be_in_future
    unless date_of_birth < Date.today
      errors.add(:date_of_birth, "can not be in the future.")
    end
  end

  def full_name
    self.first_name + " " + self.last_name
  end

  def full_name_must_be_unique
    name = self.full_name
    if Client.all.any? { |c| name == c.first_name + " " + c.last_name }
      errors.add(:base, "Client already exists.")
    end
  end

  def profile_image_size
    if profile_image.size > 5.megabytes
      errors.add(:profile_image, "should be less than 5MB")
    end
  end

  def strip_names
    first_name.strip!
    last_name.strip!
  end

  def age
    Time.zone.now.year - self.date_of_birth.year - 1
  end
end
