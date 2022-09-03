class HomeController < ApplicationController
  def index 
    @tags = Tag.all
    @properties = Property.all
  end

  def get_user_by_email 
    user = User.find_by(email: params[:email])

    unless user.nil? 
      redirect_to new_user_session_path
    else
      redirect_to new_user_registration_path
    end
  end
end
