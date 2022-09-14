class ReservationMailer < ApplicationMailer
  def reservation_created_email 
    @user = params[:user] 
    @property = params[:property] 
    @reservation = params[:reservation]
    mail(to: @user.email, subject: 'New reservation!')
  end
end
