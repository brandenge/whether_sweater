class RoadTripSerializer
  include JSONAPI::Serializer

  set_id nil
  set_type 'roadtrip'

  attributes :start_city,
             :end_city,
             :travel_time

  attribute :weather_at_eta do |road_trip|
    weather_at_eta = road_trip.weather_at_eta
    {
      datetime: weather_at_eta.datetime,
      temperature: weather_at_eta.temperature,
      condition: weather_at_eta.condition
    }
  end
end
