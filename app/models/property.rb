class Property < ApplicationRecord
  validates :name, presence: true
  validates :headline, presence: true 
  validates :description, presence: true 
  validates :street, presence: true
  validates :city, presence: true 
  validates :country, presence: true

  geocoded_by :address
  after_validation :geocode, if: ->{ latitude.blank? && longitude.blank? }

  def address
    [street, city, state, country].compact.join(', ')
  end
end
