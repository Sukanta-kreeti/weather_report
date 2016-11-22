class HomeController < ApplicationController
  def index
    lan = request.location.longitude
    lat = request.location.latitude
    date = if params[:date]
             DateTime.parse(params[:date])
           else
             Time.new(Date.today.year, Date.today.month, Date.today.day)
           end

    @forecast = ForecastIO.forecast(lat, lan, :time => date.to_i, params: { units: 'si', exclude: ["minutely", "alerts"] })

    respond_to do |format|
      if request.xhr?
        format.js
      else
        format.html
      end
    end
  end
end
