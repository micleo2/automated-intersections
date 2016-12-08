require_relative "driver_agent"

class CarSystem
  attr_accessor :agents, :average_wait_time

  def initialize
    
  end

  def update
  end

  def generate_car
    new_agent = DriverAgent.new
    @agents << new_agent
  end

  def on_exit(seconds)

  end

  def get_neighbors(car)

  end
end
