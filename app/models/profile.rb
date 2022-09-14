class Profile < ApplicationRecord
  belongs_to :user

  has_one_attached :identification_image, dependent: :destroy
end
