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

  private

  def notify_recipient
    ReservationNotification.with(reservation: self).deliver_later(self.property.owner)
  end

  def cleanup_notifications 
    notifications_as_reservation.destroy_all
  end
end
