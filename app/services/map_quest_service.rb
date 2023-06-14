class MapQuestService
  def get_city_lat_lng(city, state)
    url = "/geocoding/v1/address?key=#{ENV['MAP_QUEST_API_KEY']}&location=#{city.capitalize},#{state.upcase}"
    location_data = get_url(url)
    location_data[:results].first[:locations].first[:latLng]
  end

  private

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
