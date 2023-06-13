class LocationFacade
  def get_city_lat_lng(city, state)
    service.get_city_lat_lng(city, state)
  end

  private

  def service
    @_service ||= MapQuestService.new
  end
end
