class PropertyController < ApplicationController
  def show 
    @property = Property.find(params[:id])

    @date_ranges = []
    @property.reservations.each do |reservation|
      @date_ranges << ["#{reservation.from}", "#{reservation.to}"]
    end
  end
end
