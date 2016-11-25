module ApplicationHelper

  #check if a css file exists or not before loading the same
  def stylesheet_exists?(stylesheet)
    stylesheet = "#{Rails.root}/app/assets/stylesheets/#{stylesheet}.css"
    File.exists?(stylesheet) || File.exists?("#{stylesheet}.sass")
  end

  #check if a js file exists or not before loading the same
  def javascript_exists?(script)
    script = "#{Rails.root}/app/assets/javascripts/#{script}.js"
    extensions = %w(.coffee .erb .coffee.erb) + [""]
    extensions.inject(false) do |truth, extension|
      truth || File.exists?("#{script}#{extension}")
    end
  end

  def weather_icon_class(data)
    "wi-night-clear"
  end

  def convert_unix_time_to_date_format(unix_time)
    Time.at(unix_time).strftime("%B %d, %Y")
  end
end
