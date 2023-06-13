class WeatherService
  BASE_URL = 'https://api.weatherapi.com'.freeze

  def get_forecast(coordinates)
    param = "#{coordinates[:lat]},#{coordinates[:lng]}"
    weather_data = get_url('/v1/forecast.json?', param)
    format_weather_data(weather_data)
  end

  private

  def format_weather_data(weather_data)
    current = weather_data[:current]
    daily = weather_data[:forecast][:forecastday]
    hourly = weather_data[:forecast][:forecastday].first[:hour]

    {
      current_weather: {
        last_updated: current[:last_updated],
        temperature: current[:temp_f],
        feels_like: current[:feelslike_f],
        humidity: current[:humidity],
        uvi: current[:uv],
        visibility: current[:vis_miles],
        condition: current[:condition][:text],
        icon: current[:condition][:icon],
      },
      daily_weather: daily.map do |day|
        {
          date: day[:date],
          sunrise: day[:astro][:sunrise],
          sunset: day[:astro][:sunset],
          max_temp: day[:day][:maxtemp_f],
          min_temp: day[:day][:mintemp_f],
          condition: day[:day][:condition][:text],
          icon: day[:day][:condition][:icon]
        }
      end,
      hourly_weather: hourly.map do |hour|
        {
          time: hour[:time][-5..],
          temperature: hour[:temp_f],
          condition: hour[:condition][:text],
          icon: hour[:condition][:icon]
        }
      end
    }
  end

  def get_url(url, param)
    response = conn(param).get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn(param)
    Faraday.new(
      url: BASE_URL,
      headers: { 'Content-Type' => 'application/json' },
      params: {
        key: ENV['WEATHER_API_KEY'],
        q: param
      }
    )
  end
end
