require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
  property = Property.first
  
  context "GET #show" do
    it "return a success response" do 
      get :show, params: {id: property.id} 
      expect(response).to have_http_status(200)  
    end
  end
end
