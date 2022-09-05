class HomeController < ApplicationController
  def index 
    @tags = Tag.all
    @properties = Property.where(status: "active")
  end

  def authenticate_email
    user = User.find_by!(email: params[:email])

    respond_to do |format| 
      format.json do 
        render json: user.to_json, status: :ok
      end
    end

  rescue ActiveRecord::RecordNotFound => e
    respond_to do |format| 
      format.json do 
        render json: { error: e.message }.to_json, status: 404
      end
    end
  end
end
