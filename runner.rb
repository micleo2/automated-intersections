require_relative "seeking_agent"
require_relative "scenery"
load_libraries :vecmath

def setup
  size 750, 900
  @mouse_follower = SeekingAgent.new Vec2D.new(width/2, height/2), 2
end

def draw
  background 255
  Scenery::draw_road 100
  Scenery::draw_lanes
  fill 255, 0, 0
  ellipse mouse_x, mouse_y, 12, 12
  @mouse_follower.draw
  @mouse_follower.update Vec2D.new mouse_x, mouse_y
end
