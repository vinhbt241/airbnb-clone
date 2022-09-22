require 'rails_helper'


RSpec.describe ReservationsController, type: :controller do
  context "GET #index" do
    it "create redirect signal if user not logged in" do 
      get :index
      expect(response).to have_http_status(302)  
    end

    it "return a success response when user is logged in" do
      User.first ? @user = User.first : @user = create(:user)
      sign_in @user

      get :index
      expect(response).to have_http_status(200)  
    end
  end

  context "GET #show" do
    it "create redirect signal if user not logged in" do 
      get :show, params: {id: 1}
      expect(response).to have_http_status(302)  
    end

    it "return a success response when user is logged in" do 
      @user = create(:user)
      sign_in @user

      reservation = create(:reservation, user: @user)

      get :show, params: {id: reservation.id}
      expect(response).to have_http_status(200)  
    end
  end

  context "GET #new" do
    it "create redirect signal if user not logged in" do 
      get :new
      expect(response).to have_http_status(302)  
    end

    it "return a success response when user is logged in" do 
      @user = create(:user)
      sign_in @user

      property = create(:property)
      
      get :new, params: {property_id: property.id}
      expect(response).to have_http_status(200)  
    end
  end

  # context "POST #create" do 
  #   it "return a error status when reservation's date range is overlapped" do 
  #     @user = create(:user)
  #     sign_in @user

  #     @property = create(:property)

  #     post :create, params: {
  #       property_id: @property.id, 
  #       user_id: @user.id, 
  #       from: Date.new(2022, 9, 15), 
  #       to: Date.new(2022, 9, 16),
  #       status: "processing"
  #     }
  
  #     expect(response).to have_http_status(422)
  #   end
  # end
end
