class ForecastController < ApplicationController
  def search
    coordinates = LocationFacade.new.get_city_lat_lon(params[:city], params[:state])
    weather_data = WeatherForecastFacade.new.get_forecast(coordinates)
    require 'pry-byebug'; require 'pry'; binding.pry;
    render json: WeatherForecastSerializer.new(weather_data).serializable_hash.to_json, status: 200
  end
end
