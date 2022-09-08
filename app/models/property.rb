class Property < ApplicationRecord
  validates :street, :city, :country, presence: true, if: :active_or_address?
  validates :headline, presence: true, if: :active_or_headline?
  validates :description, presence: true, if: :active_or_description?

  geocoded_by :address
  after_validation :geocode, if: ->{ latitude.blank? && longitude.blank? }

  has_many_attached :images, dependent: :destroy
  
  belongs_to :owner, class_name: "User"

  # has_many :reservations, dependent: :destroy
  # has_many :guests, through: :reservations, source: :user

  def address
    # [street, city, state, country].compact.join(', ')
    country
  end

  def default_image 
    images.first
  end

  def active?
    status == 'active'
  end

  def active_or_address? 
    status.include?('address') || active?
  end

  def active_or_headline? 
    status.include?('headline') || active?
  end

  def active_or_description? 
    status.include?('description') || active?
  end
end
