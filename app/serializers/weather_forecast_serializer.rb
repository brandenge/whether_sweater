class WeatherForecastSerializer
  include JSONAPI::Serializer

  set_id do |_|
    nil
  end
  set_type :forecast

  attributes :current_weather,
             :daily_weather,
             :hourly_weather
end
