class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_#{params[:user_id]}"
    
    # if user_signed_in?
    #   notifications = Property.where.not(status: "active").count + Reservation.where(status: "processing").count

    #   ActionCable.server.broadcast("notification_#{current_user.id}", {action: "set_notifications", notifications: notifications})
    # end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
