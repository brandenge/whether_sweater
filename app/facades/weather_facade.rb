class WeatherFacade
  def get_forecast(coordinates)
    forecast_data = service.get_forecast(coordinates)
    WeatherForecast.new(forecast_data)
  end

  private

  def service
    @_service ||= WeatherService.new
  end
end
