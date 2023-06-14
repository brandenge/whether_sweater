class MapFacade
  def get_city_lat_lng(location)
    service.get_city_lat_lng(location)
  end

  private

  def service
    @_service ||= MapQuestService.new
  end
end
