class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    @posts = Post.where({ "place_id" => @place["id"] },{ "user_id" => @current_user["id"] })
  end

  def new
    @place = Place.new
  end

  def create
    if @current_user
          @place = Place.new
          @place["name"] = params["place"]["name"]
          @place.save
    else
      flash["notice"] = "Login first."
    end
    if @current_user
      redirect_to "/places/"
    else
      redirect_to "/login"
    end
  end

end
