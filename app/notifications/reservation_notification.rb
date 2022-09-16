# To deliver this notification:
#
# ReservationNotification.with(post: @post).deliver_later(current_user)
# ReservationNotification.with(post: @post).deliver(current_user)

class ReservationNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  def message
    @property = Property.find(params[:reservation][:property_id])
    
    "Property at #{@property.city} has been reserved"
  end
  
  def url
    owner_property_reservations_path(property_id: params[:reservation][:property_id])
  end
end
