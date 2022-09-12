class Property < ApplicationRecord
  validates :street, :city, :country, presence: true, if: :pending_or_address?
  validates :headline, presence: true, if: :pending_or_headline?
  validates :description, presence: true, if: :pending_or_description?

  geocoded_by :address
  after_validation :geocode, if: ->{ latitude.blank? && longitude.blank? }

  has_many_attached :images, dependent: :destroy
  
  belongs_to :owner, class_name: "User"

  has_many :reservations, dependent: :destroy
  has_many :guests, through: :reservations, source: :user

  def address
    # [street, city, state, country].compact.join(', ')
    country
  end

  def default_image 
    images.first
  end

  def pending?
    status == 'pending'
  end

  def pending_or_address? 
    status.include?('address') || pending?
  end

  def pending_or_headline? 
    status.include?('headline') || pending?
  end

  def pending_or_description? 
    status.include?('description') || pending?
  end
end
