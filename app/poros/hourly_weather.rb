class HourlyWeather
  attr_reader :time,
              :temperature,
              :conditions,
              :icon

  def initialize(data)
    @time = data[:time]
    @temperature = data[:temperature]
    @conditions = data[:conditions]
    @icon = data[:icon]
  end
end
