class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    if @current_user
    @place = Place.find_by({ "id" => params["id"] })
    @posts = Post.where({ "place_id" => @place["id"]}).where({"user_id" => @current_user["id"]})
    else
    flash["notice"] = "Login first."
    redirect_to "/login"
    end

  end

  def new
    if @current_user
    @place = Place.new
    else
      redirect_to "/login"
    end
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
