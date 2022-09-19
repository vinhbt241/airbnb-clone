class ReviewsController < ApplicationController
  def create 
    @review = Review.new(
      rating: params[:rating],
      body: params[:body],
      reviewable_id: params[:reviewable_id], 
      reviewable_type: params[:reviewable_type], 
      user_id: params[:user_id]
    )

    @reservation = Reservation.find(params[:reservation_id])

    if @review.save 
      flash.notice = "Review success!"
      @reservation.update(status: "completed")
      redirect_to reservation_path(@reservation)
    end
  end
end
