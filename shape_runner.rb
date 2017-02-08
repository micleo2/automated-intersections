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
  @timer = 50
  @spawner = CarSpawner.new @all_cars, 100, $width, $height
  @all_cars << @spawner.create_car
end

def mouse_pressed
  puts "[@w/2 - #{mouse_x - $width/2}, #{mouseY}]"
end

def draw
  @timer -= 1
  frame_rate 23
  background 255
  Scenery::draw_road 150
  Scenery::draw_lanes
  @all_cars.each(&:update)
  @all_cars.each(&:draw)
  @all_cars.delete_if{|c| c.path.reached_destination? c.agent}
  if @timer < 0
    @all_cars << @spawner.create_car
    @timer = 45
  end
  @all_cars.each{|c| c.react_to @all_cars}
end
