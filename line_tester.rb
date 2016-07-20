require_relative "math_util"
require_relative "scenery"

load_libraries :vecmath

def setup
  size 750, 900
  @line_one = MathUtil::Line.from_coordinates(width/2-100, height/2-100, width/2+100, height/2+100)
  @line_two = MathUtil::Line.from_coordinates(width/2+100, height/2-100, width/2-100, height/2+100)
  @point = @line_one.point_of_intersection @line_two
end

def draw
  mouse_vec = Vec2D.new mouse_x, mouse_y
  background 255
  Scenery::draw_road 100
  Scenery::draw_lanes
  @line_one.draw
  @line_two.draw
  if @point.nil?
    text "NO CROSSNG", width/2, height/2
  else
    fill 0
    ellipse @point.x, @point.y, 40, 40
  end
end
