require_relative "seeking_agent"
require_relative "scenery"
require_relative "route"
require_relative "bezier_curve"
require_relative "driver_agent"
require_relative "car_spawner"
require_relative "summary_statistics"
require_relative "button"
require_relative "config"
require_relative "math_util"

load_libraries :vecmath
$width = 750
$height = 900
def setup
  size $width, $height
  @shapeA = ShapeFactory.create_rectangle.transform_by(300, 300)
  @shapeB = ShapeFactory.create_triangle.transform_by(250, 300)
  @avg = MathUtil::average_point @shapeA, @shapeA
end

def draw
  frame_rate 50
  background 255
  Scenery::draw_road 150
  Scenery::draw_lanes
  stroke 255, 0, 0
  @shapeA.draw
  @shapeB.draw
  stroke 0, 255, 0
  fill 0
  ellipse @avg.x, @avg.y, 12, 12
end
