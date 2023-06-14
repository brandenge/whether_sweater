class MapQuestService
  def get_city_lat_lng(city, state)
    url = "/geocoding/v1/address?key=#{ENV['MAP_QUEST_API_KEY']}&location=#{city.capitalize},#{state.upcase}"
    location_data = get_url(url)
    messages = location_data[:info][:messages]
    if valid_location?(location_data)
      location_data[:results].first[:locations].first[:latLng]
    end
  end

  def get_directions(origin, destination)

  end

  private

  def valid_location?(location_data)
    messages = location_data[:info][:messages]
    if location_data[:results].first[:locations].first[:source] == 'FALLBACK'
      raise CustomError.new('No location found. Please provide a known location query parameter.', 400)
    elsif !messages.empty?
      raise CustomError.new(messages.first, 400)
    else
      true
    end
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(
      url: 'https://www.mapquestapi.com',
      headers: { 'Content-Type' => 'application/json' }
    )
  end
end
