class PropertyController < ApplicationController
  before_action :authenticate_user!

  def create 
    Reservation.create(reservation_params)
  end

  private 

  def reservation_params 
    
  end
end
