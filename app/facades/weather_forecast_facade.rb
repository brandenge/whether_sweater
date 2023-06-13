class WeatherForecastFacade
  def get_forecast(coordinates)
    forecast_data = service.get_forecast(coordinates)
    WeatherForecast.new(**forecast_data)
  end

  private

  def service
    @_service ||= WeatherForecastService.new
  end
end
