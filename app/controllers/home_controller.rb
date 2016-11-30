class HomeController < ApplicationController
  before_filter :setup_date
  before_filter :setup_coordinate

  def index
    if request.xhr?
      @forecast = ForecastIO.forecast(@lat, @lan, :time => @date.to_i, params: { exclude: ["minutely", "alerts"] })
      respond_to do |format|
        format.js
      end
    end
  end

  def weekly_report
    if request.xhr?
      @forecast = ForecastIO.forecast(@lat, @lan, params: { exclude: ["currently", "horly", "minutely", "alerts"] })
      respond_to do |format|
        format.js
      end
    end
  end

  def show_graph
    @forecast = ForecastIO.forecast(@lat, @lan, time: @date.to_i, params: { exclude: ["minutely", "alerts"] })
    respond_to do |format|
      format.js
    end
  end

  private

  def setup_date
    @date = params[:date].present? ? DateTime.parse(params[:date]).in_time_zone(cookies[:timezone]) : DateTime.now.in_time_zone(cookies[:timezone])
  end

  def setup_coordinate
    if params[:coords].present?
      @lan = params[:coords][:longitude]
      @lat = params[:coords][:latitude]
    end
  end
end
