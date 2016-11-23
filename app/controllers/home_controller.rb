class HomeController < ApplicationController
  def index
    if request.xhr?
      lan = params[:coords][:longitude]
      lat = params[:coords][:latitude]
      date = DateTime.parse(params[:date])

      @forecast = ForecastIO.forecast(lat, lan, :time => date.to_i, params: { units: 'si', exclude: ["minutely", "alerts"] })
      respond_to do |format|
        format.js
      end
    end
  end
end
