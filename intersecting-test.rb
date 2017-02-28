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
  @cast = ShapeFactory.create_cast.transform_by $width/2, $height/2
  @img = load_image "topdown_car.png"
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
  @cast.fill_draw 255, 0, 0
  @hit.fill_draw 0, 0, 255
  if (MathUtil::polygons_intersect? @cast, @hit)
    fill 255, 0, 0
    text_size 40
    text "COLLISON", 40, 40
  else
    fill 255, 255, 255
  end
  push_matrix
  translate $width/2, $height/2
  rotate Math::atan2 -1, 0
  image_mode CENTER
  scale 0.04
  image @img, 0, 0
  pop_matrix
end
