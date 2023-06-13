FactoryBot.define do

  factory :weather_forecast do
    skip_create

    current_date = Faker::Time.between(from: DateTime.now - 10, to: DateTime.now)
    current_temperature = Faker::Number.between(from: 0, to: 90)

    factory :current_weather do
      skip_create

      last_updated { current_date.strftime('%Y-%m-%d %H:%M') }
      temperature { current_temperature }
      feels_like {
        Faker::Number.between(from: current_temperature - 10, to: current_temperature + 10)
      }
      humidity { Faker::Number.between(from: 1, to: 100) }
      uvi { Faker::Number.between(from: 1, to: 11) }
      visibility { Faker::Number.between(from: 20, to: 50) }
      condition { ['Sunny', 'Rain', 'Snow', 'Partly Cloudy'].sample }
      icon { condition.downcase.delete('-').delete('.png') }

      initialize_with { new(attributes) }
    end

    factory :daily_weather do
      skip_create

      date { (current_date).strftime('%Y-%m-%d %H:%M') }
      sunrise { '07:15 AM' }
      max_temp { current_temperature + 15 }
      min_temp { current_temperature - 15 }
      condition { ['Sunny', 'Rain', 'Snow', 'Partly Cloudy'].sample }
      icon { ['sunny.png', 'rain.png', 'snow.png', 'partly-cloudy.png'].sample }

      initialize_with { new(attributes) }
    end

    factory :hourly_forecast do
      skip_create

      time { "00:00" }
      temperature { Faker::Number.between(from: current_temperature - 5, to: current_temperature + 5) }
      conditions { ['Sunny', 'Rain', 'Snow', 'Partly Cloudy'].sample }
      icon { ['sunny.png', 'rain.png', 'snow.png', 'partly-cloudy.png'].sample }

      initialize_with { new(attributes) }
    end

    current_weather { create(:current_weather) }
    daily_weather {
      create_list(:daily_weather, 5) do |daily_weather, index|
        daily_weather(date: (current_date + 1 + index).strftime('%Y-%m-%d %H:%M'))
      end
    }
    hourly_weather {
      create_list(:hourly_weather, 24) do |hourly_weather, index|
        hourly_weather(time: "#{'%02d' % index}:00" )
      end
    }
  end

  initialize_with { new(attributes) }
end
