class Reservation < ApplicationRecord
  extend Enumerize
  enumerize :status, in: %W[processing success failure]

  belongs_to :property
  belongs_to :user

  def date_range_overlap?(from_date, to_date) 
    from_date <= to && from <= to_date
  end
end
