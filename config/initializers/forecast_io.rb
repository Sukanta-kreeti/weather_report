require 'forecast_io'

ForecastIO.configure do |configuration|
  configuration.api_key = Rails.application.secrets.forecast_api_key
end
