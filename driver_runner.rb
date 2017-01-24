require_relative "seeking_agent"
require_relative "scenery"
require_relative "route"
require_relative "bezier_curve"
require_relative "driver_agent"
require_relative "car_spawner"

load_libraries :vecmath
$width = 750
$height = 900
def setup
  size $width, $height
  @all_cars = []
  @spawner = CarSpawner.new @all_cars, 100, $width, $height
  @all_cars << @spawner.create_car
end

def mouse_pressed
  puts "[#{mouse_x}, #{mouseY}]"
end

def draw
  frame_rate 20
  background 255
  Scenery::draw_road 150
  Scenery::draw_lanes
  @all_cars.each(&:update)
  @all_cars.each(&:draw)
  # @all_cars.each{|c| c.react_to @all_cars}
end