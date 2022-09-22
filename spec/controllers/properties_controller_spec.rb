require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
  context "GET #show" do
    it "return a success response" do 
      property = create(:property)
      get :show, params: {id: property.id} 
      expect(response).to have_http_status(200)  
    end
  end
end
