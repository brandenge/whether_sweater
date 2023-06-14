class WeatherForecastSerializer
  include JSONAPI::Serializer

  set_id { |_| nil }

  set_type :forecast

  attribute :current_weather do |weather_forecast|
    {
      last_updated: weather_forecast.current_weather.last_updated,
      temperature: weather_forecast.current_weather.temperature,
      feels_like: weather_forecast.current_weather.feels_like,
      humidity: weather_forecast.current_weather.humidity,
      uvi: weather_forecast.current_weather.uvi,
      visibility: weather_forecast.current_weather.visibility,
      condition: weather_forecast.current_weather.condition,
      icon: weather_forecast.current_weather.icon
    }
  end
  attribute :daily_weather do |weather_forecast|
    weather_forecast.daily_weather.map do |day|
      {
        date: day.date,
        sunrise: day.sunrise,
        sunset: day.sunset,
        max_temp: day.max_temp,
        min_temp: day.min_temp,
        condition: day.condition,
        icon: day.icon
      }
    end
  end
  attribute :hourly_weather do |weather_forecast|
    weather_forecast.hourly_weather.map do |hour|
      {
        time: hour.time,
        temperature: hour.temperature,
        condition: hour.condition,
        icon: hour.icon
      }
    end
  end
end
