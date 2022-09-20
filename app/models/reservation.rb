class Reservation < ApplicationRecord
  extend Enumerize
  enumerize :status, in: %W[processing success failure completed]

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: "Notification"

  belongs_to :property
  belongs_to :user

  def date_range_overlap?(from_date, to_date) 
    from_date <= to && from <= to_date
  end

  def status_step 
    case status 
    when "processing" 
      return 1
    when "success" || "failure"
      return 2
    when "completed"
      return 3
    end
  end 

  def status_style
    case self.status 
    when "processing"
      return "bg-amber-500 text-black text-center p-3 rounded-xl w-32 hover:brightness-90"
    when "success"
      return "bg-green-500 text-white text-center p-3 rounded-xl w-32 hover:brightness-90"
    when "completed"
      return "bg-white text-gray-600 border-2 border-gray-500 text-center p-3 rounded-xl w-32 hover:brightness-90"
    end
  end

  def nights
    (self.to - self.from).to_i
  end

  def location_fee 
    nights * self.property.price
  end

  def cleaning_fee 
    0
  end

  def service_fee 
    0
  end

  def total_price 
    location_fee + cleaning_fee + service_fee
  end

  private

  def notify_recipient
    ReservationNotification.with(reservation: self).deliver_later(self.property.owner)
  end

  def cleanup_notifications 
    notifications_as_reservation.destroy_all
  end
end
