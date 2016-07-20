require_relative "seeking_agent"
require_relative "scenery"
require_relative "route"
require_relative "bezier_curve"

load_libraries :vecmath

def setup
  size 750, 900
  @mouse_follower = SeekingAgent.new Vec2D.new(width/2 + 21, height - 30), 2
  @other_car = SeekingAgent.new Vec2D.new(width/2 + 21, 30), 2
  curvature = 45
  @curve = BezierCurve.new(Vec2D.new(width/2 + 35, height/2 + 85), Vec2D.new(width/2 + curvature, height/2 - curvature), Vec2D.new(width/2 - 80, height/2 - 25))
  # @path = Route.from_bezier @curve, 10
  arr = [Vec2D.new(403.0, 507.0),Vec2D.new(403.0, 485.0),Vec2D.new(404.0, 466.0),Vec2D.new(393.0, 446.0),Vec2D.new(373.0, 430.0),Vec2D.new(332.0, 424.0),Vec2D.new(287.0, 424.0),Vec2D.new(227.0, 424.0),Vec2D.new(36.0, 422.0)]
  @path = Route.new arr, 10
end

def draw
  mouse_vec = Vec2D.new mouse_x, mouse_y
  background 255
  Scenery::draw_road 100
  Scenery::draw_lanes
  @mouse_follower.draw
  @other_car.draw
  if @path.reached_destination?
    @mouse_follower.steering.arrive @path.current_point, 100
    # text "STOPPING...", width/2, 34
  else
    @mouse_follower.steering.seek @path.current_point
  end
  @mouse_follower.steering.avoid(mouse_vec, 20){|predicted_pos| (predicted_pos - mouse_vec).mag < 10}
  @mouse_follower.steering.update
  @path.adjust_to @mouse_follower
  # @path.draw
  stroke 180, 180, 180
  no_fill
  ellipse @mouse_follower.position.x, @mouse_follower.position.y, 5, 5
end
