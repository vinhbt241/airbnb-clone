class Admin::HomeController < ApplicationController
  def index 
    @users = User.all
  end

  def show_properties 
    @properties = Property.all
  end

  def show_reservations 
    @reservations = Reservation.all
  end
end
