class SummaryStatistics
  attr_accessor :mean, :n, :standard_deviation, :wait_times, :cars_serviced, :crashes
  def initialize
    @mean = @n = @standard_deviation = @crashes = 0
    @wait_times = []
  end

  def save_data
    puts "Wait times: #{@wait_times}"
    puts "Average wait time: #{avg_time}"
    puts "Crashes: #{@crashes/2}"
    puts "Cars serviced: #{@wait_times.length}" #amount of cars serviced
  end

  def avg_time
    if @wait_times.empty?
      return 0
    else
      return @wait_times.reduce(&:+).fdiv @wait_times.length
    end
  end
end
