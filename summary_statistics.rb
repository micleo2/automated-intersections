class SummaryStatistics
  attr_accessor :mean, :n, :standard_deviation, :wait_times, :cars_serviced
  def initialize
    @mean = @n = @standard_deviation = 0
    @wait_times = []
  end

  def save_data
    p "Wait times: #{@wait_times}"
    p "Crashes: #{@crashes}"
    p "Cars serviced: #{@wait_times.length}" #amount of cars serviced
  end
end
