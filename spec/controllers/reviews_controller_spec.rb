require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  context "POST #create" do 
    it "redirect to new page when review was created successfully" do 
      @user = User.first
      sign_in @user

      post :create, params: {
        rating: 3, 
        body: "Nice place",
        reviewable_id: Property.first.id, 
        reviewable_type: "Property",
        user_id: User.first.id, 
        reservation_id: Reservation.first.id
      }

      expect(response).to redirect_to(reservation_path(Reservation.first)) 

      Reservation.first.update(status: "success")
    end
  end
end
