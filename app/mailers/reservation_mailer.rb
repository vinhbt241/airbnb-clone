class ReservationMailer < ApplicationMailer
  def reservation_created_email 
    @reservation = params[:reservation]
    @user = @reservation.property.owner
    @property = @reservation.property
    mail(to: @user.email, subject: 'New reservation!')
  end

  def reservation_success_email 
    @reservation = params[:reservation]
    @user = @reservation.user
    @property = @reservation.property
    mail(to: @user.email, subject: 'Reservation success!')
  end
end
