require_relative "seeking_agent"
require_relative "scenery"
require_relative "route"
require_relative "bezier_curve"

load_libraries :vecmath

def setup
  size 750, 900
  @mouse_follower = SeekingAgent.new Vec2D.new(width/2 + 21, height - 30), 2
  curvature = 45
  @curve = BezierCurve.new(Vec2D.new(width/2 + 35, height/2 + 85), Vec2D.new(width/2 + curvature, height/2 - curvature), Vec2D.new(width/2 - 80, height/2 - 25))
  @path = Route.from_bezier @curve, 10
end

def draw
  background 255
  Scenery::draw_road 100
  Scenery::draw_lanes
  @mouse_follower.draw
  @mouse_follower.update @path.current_point, 100
  @path.adjust_to @mouse_follower
  @path.draw
  stroke 180, 180, 180
  no_fill
  ellipse @mouse_follower.position.x, @mouse_follower.position.y, 5, 5
end
