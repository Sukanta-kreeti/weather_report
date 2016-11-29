module HomeHelper
  def graph_content forecast, title = "Temp(C)"
    data = {}
    formated_data = format forecast.hourly.data
    data[:labels] = formated_data.keys.map {|unix_time| Time.at(unix_time).hour}
    data[:datasets] = [{
                        label: title,
                        backgroundColor: "rgba(255, 99, 132, 0.2)",
                        borderColor: "rgba(255,99,132,1)",
                        data: formated_data.values
                      }]
    data
  end

  private

  def format data
    data_in_arr = data.map { |h_data| [h_data.time, h_data.temperature] }
    data_in_hash = Hash[data_in_arr]
  end
end
