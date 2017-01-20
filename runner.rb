require_relative "seeking_agent"
require_relative "scenery"
require_relative "route"
require_relative "bezier_curve"

load_libraries :vecmath

def setup
  size 750, 900
  curvature = 45
  @mouse_follower = SeekingAgent.new Vec2D.new(width/2 + 35, height/2 + 305), 2
  @path = Route.from_bezier BezierCurve.new(Vec2D.new(width/2 + 35, height/2 + 105), Vec2D.new(width/2 + 35, height/2), Vec2D.new(width/2 + 35, height/2 - 105)), 10
  @car = SeekingAgent.new Vec2D.new(width/2 + 370, height/2 - 40), 2
  @opath = Route.from_bezier BezierCurve.new(Vec2D.new(width/2 + 115, height/2 - 40), Vec2D.new(width/2, height/2 - 40), Vec2D.new(width/2 - 115, height/2 - 40)), 10
  @all_cars = [@car, @mouse_follower]
end

def mouse_pressed
  puts "[#{mouse_x}, #{mouseY}]"
end

def draw
  frame_rate 20
  background 255
  Scenery::draw_road 150
  Scenery::draw_lanes
  @mouse_follower.draw
  @car.draw

  if @path.reached_destination?
    @mouse_follower.steering.arrive @path.current_point, 100
  else
    @mouse_follower.steering.seek @path.current_point
  end
  if @opath.reached_destination?
    @car.steering.arrive @opath.current_point, 100
  else
    @car.steering.seek @opath.current_point
  end
  @mouse_follower.steering.update
  @car.steering.update
  @opath.adjust_to @car
  @path.adjust_to @mouse_follower
  @path.draw
  @opath.draw
  @car.time_in_intersection += 2

  # dist = (@car.position - @mouse_follower.position).mag
  @all_cars.each{|c| c.react_to @all_cars}
  # if dist < 90
  #   slow_down = [@car, @mouse_follower].max_by{|c| c.time_in_intersection * -1}
  #   slow_down.velocity *= 0.8
  # end
end
