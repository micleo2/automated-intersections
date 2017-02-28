require_relative "math_util"

class SummaryStatistics
  attr_accessor :mean, :n, :standard_deviation, :wait_times, :cars_serviced, :crashes
  def initialize
    @mean = @n = @standard_deviation = @crashes = 0
    @wait_times = []
  end

  def save_data
    # puts "Wait times: #{@wait_times}"
    puts "Average wait time: #{avg_time}"
    puts "Crashes: #{@crashes/2}"
    puts "Cars serviced: #{@wait_times.length}" #amount of cars serviced
    #log output to a text file
    f = File.new(MathUtil::unique_name + ".txt", "w")
    f.puts "Average wait time: #{avg_time}"
    f.puts "Crashes: #{crashes/2}"
    f.puts "Cars serviced: #{@wait_times.length}"
    f.puts "Crash rate: #{(@crashes/2).fdiv @wait_times.length}"
    @wait_times.each{|t| f.puts t}
    f.close
  end

  def avg_time
    if @wait_times.empty?
      return 0
    else
      return @wait_times.reduce(&:+).fdiv @wait_times.length
    end
  end
end
