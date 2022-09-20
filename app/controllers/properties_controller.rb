class PropertiesController < ApplicationController
  def show 
    @property = Property.includes(:reviews, images_attachments: :blob).find(params[:id])

    @date_ranges = []
    @property.reservations.each do |reservation|
      @date_ranges << ["#{reservation.from}", "#{reservation.to}"]
    end
  end
end
