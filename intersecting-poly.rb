# require "clipper"
require_relative "seeking_agent"
require_relative "scenery"
require_relative "route"
require_relative "bezier_curve"
require_relative "driver_agent"
require_relative "car_spawner"

load_libraries :vecmath
$width = 750
$height = 900
def setup
  size $width, $height
  @cast = ShapeFactory.create_square.transform_by $width/2, $height/2
  @hit = ShapeFactory.create_square.transform_by $width/2, $height/2 + 200
  # @clip = Clipper.new
  # @clip.add_subject_polygon @hit.to_a
  # @clip.add_clip_polygon @cast.to_a
  # p @clip.intersection
end

def key_pressed
  @cast.transform_by(0, -10) if key_code == 38
  @cast.transform_by(0, 10) if key_code == 40
  @cast.transform_by(-10, 0) if key_code == 37
  @cast.transform_by(10, 0) if key_code == 39
  @cast.rotate_by(Math::PI / 5) if key_code == 32
end

def draw
  background 255
  @cast.draw
  @hit.draw
  if (@cast.collide? @hit)
    fill 255, 0, 0
    text_size 40
    text "COLLISON", 40, 40
  else
    fill 255, 255, 255
  end
end