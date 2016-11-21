require_relative "seeking_agent"
require_relative "scenery"
require_relative "route"
require_relative "bezier_curve"

load_libraries :vecmath

def setup
  size 750, 900
  curvature = 45
  @mouse_follower = SeekingAgent.new Vec2D.new(width/2 + 21, height - 30), 2
  @curve = BezierCurve.new(Vec2D.new(width/2 + 35, height/2 + 85), Vec2D.new(width/2 + curvature, height/2 - curvature), Vec2D.new(width/2 - 80, height/2 - 25))
  @path = Route.from_bezier @curve, 10
  @path << (Vec2D.new 12, height/2 - 25)
end

def draw
  background 255
  Scenery::draw_road 100
  Scenery::draw_lanes
  @mouse_follower.draw
  if @path.reached_destination?
    @mouse_follower.steering.arrive @path.current_point, 100
  else
    @mouse_follower.steering.seek @path.current_point
  end
  @mouse_follower.steering.update
  @path.adjust_to @mouse_follower
  @path.draw
end
