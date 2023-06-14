class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta,
              :datetime,
              :temperature,
              :condition

  def initialize(data)
    @start_city = data[:start_city]
    @end_city = data[:end_city]
    @travel_time = data[:travel_time]
    @weather_at_eta = data[:weather_at_eta]
    @datetime = data[:weather_at_eta][:datetime]
    @temperature = data[:weather_at_eta][:temperature]
    @condition = data[:weather_at_eta][:condition]
  end
end
