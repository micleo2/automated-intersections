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
  @line = MathUtil::Line.from_coordinates(400, 400, 400, 300)
  @rect = ShapeFactory.rect_from_line @line
end

def draw
  frame_rate 20
  background 255
  Scenery::draw_road 150
  Scenery::draw_lanes
  @line.draw
  stroke 0, 0, 255
  @rect.draw
end
