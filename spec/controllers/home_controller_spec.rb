require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  context "GET #index" do
    it "return a success response" do 
      get :index 
      expect(response).to have_http_status(200)  
    end
  end

  context "GET #authenticate_email" do 
    it "raise error when params is blank" do 
      get :authenticate_email, format: :json
      expect(response).to have_http_status(204)
    end

    it "return a success response when params email exist and email found" do 
      get :authenticate_email, format: :json, params: { email: User.first.email }
      expect(response).to have_http_status(200)
    end
  end
end
