class MapQuestService
  BASE_URL = 'https://www.mapquestapi.com'.freeze

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
    Faraday.new(url: BASE_URL,
      headers: { 'Content-Type' => 'application/json' })
  end
end
