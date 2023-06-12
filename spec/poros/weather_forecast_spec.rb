require 'rails_helper'

RSpec.poro WeatherForecast do
  subject(:weather_forecast) do
     create(:weather_forecast, WeatherForecastFixture::ATTRIBUTES)
  end

  describe '#initialize' do
    it 'exists' do
      expect(weather_forecast).to be_a(WeatherForecast)
    end
  end

  describe 'attributes' do
    it 'has attributes' do
      expect(weather_forecast.id).to eq(nil)
      expect(weather_forecast.name).to eq('forecast')

      current_weather = current_weather
      expect(current_weather[:last_updated]).to eq('2023-04-18 16:30')
      expect(current_weather[:temperature]).to eq(55)
      expect(current_weather[:feels_like]).to eq(45)
      expect(current_weather[:humidity]).to eq(30)
      expect(current_weather[:uvi]).to eq(2)
      expect(current_weather[:visibility]).to eq(20)
      expect(current_weather[:condition]).to eq('Partly Cloudy')
      expect(current_weather[:icon]).to eq('partly-cloudy.png')

      expect(weather_forecast.attributes[:daily_weather].count).to eq(5)
      first_daily_weather = weather_forecast.attributes[:daily_weather].first
      expect(first_daily_weather[:date]).to eq('2023-04-19')
      expect(first_daily_weather[:sunrise]).to eq('07:15 AM')
      expect(first_daily_weather[:sunset]).to eq('08:09 PM')
      expect(first_daily_weather[:max_temp]).to eq(67)
      expect(first_daily_weather[:min_temp]).to eq(43)
      expect(first_daily_weather[:condition]).to eq('Sunny')
      expect(first_daily_weather[:icon]).to eq('sunny.png')

      expect(weather_forecast.attributes[:hourly_weather].count).to eq(24)
      first_hourly_weather = weather_forecast.attributes[:hourly_weather].first
      expect(first_hourly_weather[:time]).to eq('00:00')
      expect(first_hourly_weather[:temperature]).to eq('00:00').first
      expect(first_hourly_weather[:conditions]).to eq('00:00').first
      expect(first_hourly_weather[:icon]).to eq('00:00')
    end
  end
end
