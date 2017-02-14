require_relative "seeking_agent"
require_relative "scenery"
require_relative "route"
require_relative "bezier_curve"
require_relative "driver_agent"
require_relative "car_spawner"
require_relative "math_util"

load_libraries :vecmath
$width = 750
$height = 900
def setup
  size $width, $height
  @cast = ShapeFactory.create_semi_circle.transform_by $width/2, $height/2
  # @hit = ShapeFactory.create_rectangle.align_to(Math::PI/3).transform_by $width/2, $height/2 + 200
  @hit = ShapeFactory.create_rectangle.transform_by $width/2, $height/2 + 200
end

def key_pressed
  @cast.transform_by!(0, -10) if key_code == 38
  @cast.transform_by!(0, 10) if key_code == 40
  @cast.transform_by!(-10, 0) if key_code == 37
  @cast.transform_by!(10, 0) if key_code == 39
end

def draw
  background 255
  Scenery::draw_road 150
  Scenery::draw_lanes
  @cast.draw
  @hit.draw
  if (MathUtil::polygons_intersect? @cast, @hit)
    fill 255, 0, 0
    text_size 40
    text "COLLISON", 40, 40
  else
    fill 255, 255, 255
  end
end
