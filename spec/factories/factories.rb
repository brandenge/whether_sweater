FactoryBot.define do
  factory :weather_forecast do
    skip_create

    current_date = Faker::Time.between(from: DateTime.now - 10, to: DateTime.now)
    current_temperature = Faker::Number.between(from: 0, to: 90)

    current_weather {
      last_updated { current_date.strftime('%Y-%m-%d %H:%M') }
      temperature { current_temperature }
      feels_like do
        Faker::Number.between(from: current_temperature - 10, to: current_temperature + 10)
      end
      humidity { Faker::Number.between(from: 1, to: 100) }
      uvi { Faker::Number.between(from: 1, to: 11) }
      visibility { Faker::Number.between(from: 20, to: 50) }
      condition { ['Sunny', 'Rain', 'Snow', 'Partly Cloudy'].sample }
      icon { condition.downcase.delete('-').delete('.png') }
    }

    daily_weather do
      Array.new(5).map { |_, index| daily_weather(current_date, index) }
    end

    hourly_weather do
      Array.new(24).map do |_, index|
        hourly_weather(current_temperature, index)
      end
    end
  end

  def daily_weather(current_date, index)
    {
      date: (current_date + 1 + index).strftime('%Y-%m-%d %H:%M'),
      sunrise: '07:15 AM',
      max_temp: current_temperature + 15,
      min_temp: current_temperature - 15,
      condition: ['Sunny', 'Rain', 'Snow', 'Partly Cloudy'].sample,
      icon: ['sunny.png', 'rain.png', 'snow.png', 'partly-cloudy.png'].sample
    }
  end

  def hourly_weather(current_temperature, index)
    {
      time: "0#{index}:00",
      temperature: Faker::Number.between(from: current_temperature - 5, to: current_temperature + 5),
      conditions: ['Sunny', 'Rain', 'Snow', 'Partly Cloudy'].sample,
      icon: ['sunny.png', 'rain.png', 'snow.png', 'partly-cloudy.png'].sample
    }
  end

  initialize_with { new(attributes) }
end
