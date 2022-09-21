class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create 
    @review = Review.new(review_params.except(:reservation_id))

    @reservation = Reservation.find(params[:reservation_id])

    if @review.save 
      flash.notice = "Review success!"
      @reservation.update(status: "completed")
      redirect_to reservation_path(@reservation)
    end
  end

  private

  def review_params 
    params.permit(:rating, :body, :reviewable_id, :reviewable_type, :user_id, :reservation_id)
  end
end
