require_relative "seeking_agent"
require_relative "scenery"
require_relative "route"

load_libraries :vecmath

def setup
  size 750, 900
  @mouse_follower = SeekingAgent.new Vec2D.new(width/2 + 21, height - 30), 2
  arr = [Vec2D.new(402.0, 525.0),Vec2D.new(403.0, 507.0),Vec2D.new(403.0, 490.0),Vec2D.new(403.0, 475.0),Vec2D.new(403.0, 453.0),Vec2D.new(403.0, 432.0),Vec2D.new(386.0, 425.0),Vec2D.new(359.0, 424.0),Vec2D.new(332.0, 424.0),Vec2D.new(301.0, 423.0),Vec2D.new(266.0, 423.0),Vec2D.new(204.0, 422.0),Vec2D.new(132.0, 423.0)]
  @path = Route.new arr, 10
end

def draw
  background 255
  Scenery::draw_road 100
  Scenery::draw_lanes
  @mouse_follower.draw
  @mouse_follower.update @path.current_point, 100
  @path.adjust_to @mouse_follower
  @path.draw
end
