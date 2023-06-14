class Api::V0::ForecastController < ApplicationController
  def search
    coordinates = LocationFacade.new.get_city_lat_lng(*params[:location].split(','))
    weather_data = WeatherForecastFacade.new.get_forecast(coordinates)

    render json: WeatherForecastSerializer.new(weather_data).serializable_hash.to_json, status: 200
  end
end
