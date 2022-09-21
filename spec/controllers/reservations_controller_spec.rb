require 'rails_helper'


RSpec.describe ReservationsController, type: :controller do
  context "GET #index" do
    it "create redirect signal if user not logged in" do 
      get :index
      expect(response).to have_http_status(302)  
    end

    it "return a success response when user is logged in" do
      @user = User.all.first
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
      @user = User.first
      sign_in @user

      reservation = Reservation.create(property_id: Property.first.id, user_id: User.first.id, from: Date.new(2022, 9, 15), to: Date.new(2022, 9, 20), status: "processing")

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
      @user = User.first
      sign_in @user
      
      get :new, params: {property_id: Property.first.id}
      expect(response).to have_http_status(200)  
    end
  end

  context "POST #create" do 
    it "return a error status when reservation's params are invalid" do 
      @user = User.first
      sign_in @user

      post :create, params: {
        property_id: Property.first, 
        user_id: User.first, 
        from: nil, 
        to: nil,
        status: "processing"
      }
  
      expect(response).to have_http_status(422)
    end
  end
end
