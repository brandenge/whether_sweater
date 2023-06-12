class LocationFacade
  def initialize(city, state)
    @city = city
    @state = state
  end

  def get_city_lat_lon
    service.get_city_lat_lon(@city, @state)
  end

  private

  def service
    @_service ||= MapQuestService.new
  end
end
