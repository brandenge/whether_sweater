class LocationFacade
  def get_city_lat_lng(location)
    city, state = get_city_state(location)
    service.get_city_lat_lng(city, state)
  end

  private

  def service
    @_service ||= MapQuestService.new
  end

  def get_city_state(location)
    city, state = location.split(',')
    if city.nil? || state.nil?
      raise CustomError.new('Invalid location. Please provide a valid city and state location.', 400)
    else
      [city, state]
    end
  end
end
