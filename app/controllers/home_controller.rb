class HomeController < ApplicationController
  def index 
    @tags = Tag.all
    @properties = Property.all
  end
end
