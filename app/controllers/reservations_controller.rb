class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index 
    @reservations = current_user.reservations 
  end

  def new 
    @reservation = Reservation.new(
      property_id: params[:property_id], 
      from: params[:from],
      to: params[:to]
    )

    @date_ranges = []
    Property.find(params[:property_id]).reservations.each do |reservation|
      @date_ranges << ["#{reservation.from}", "#{reservation.to}"]
    end
  end

  def create 
    @reservation = Reservation.new(reservation_params)

    if @reservation.save 
      redirect_to reservations_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private 

  def reservation_params 
    params.permit(:user_id, :property_id, :from, :to)
  end

end
