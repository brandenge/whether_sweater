class ForecastController < ApplicationController
  def search
    coordinates = LocationFacade.new.get_city_lat_lon(params[:city], params[:state])
    require 'pry-byebug'; require 'pry'; binding.pry;
  end
end
