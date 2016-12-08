require_relative "seeking_agent"
require_relative "scenery"
require_relative "route"
require_relative "bezier_curve"
require_relative "car_system"

load_libraries :vecmath

def setup
  size 750, 900
  @sys = CarSystem.new
  @timer = rand(100) + 600
end

def draw
  background 255
  Scenery::draw_road 100
  Scenery::draw_lanes
  @timer -= 1
  if @timer <= 0
    @timer = rand(100) + 600
    @sys.generate_car
  end
  @sys.update
  @sys.draw
end
