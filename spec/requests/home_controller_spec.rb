require 'rails_helper'

RSpec.describe "HomeControllers", type: :request do
  describe "Path" do
    it "route to correct action" do
      get :index 
      expect(response).to have_http_status(200) 
    end
  end
end
