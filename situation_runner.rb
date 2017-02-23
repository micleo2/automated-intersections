require_relative "scenery"
require_relative "driver_agent"
require_relative "car_spawner"

load_libraries :vecmath
$width = 750
$height = 900

def situationA
  ret = []
  spawner = CarSpawner.new spawner, 100, $width, $height
  w, h = $width, $height
  ret << spawner.create_car_from_points([Vec2D.new(w/2 + 115, h/2 - 40), Vec2D.new(w/2 - 115, h/2 - 40)])
  ret << spawner.create_car_from_points([Vec2D.new(w/2 + 35, h/2 + 105), Vec2D.new(w/2 + 35, h/2 - 105)]) #bottom one
  ret[1].agent.time_in_intersection = 100
  ret[1].agent.position.y -= 30
  ret
end

def setup
  size $width, $height
  @all_cars = []
  @all_cars += situationA
end

def draw
  frame_rate 20
  background 255
  Scenery::draw_road 150
  Scenery::draw_lanes
  @all_cars.each{|c| c.react_to @all_cars}
  @all_cars.each(&:update)
  @all_cars.each(&:draw)
  @all_cars.delete_if{|c| c.path.reached_destination? c.agent}
end
