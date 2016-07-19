require_relative "scenery"
load_libraries :vecmath

def setup
  size 750, 900
  @points = []
end

def draw
  background 255
  Scenery::draw_road 100
  Scenery::draw_lanes
  fill 255, 0, 0
  ellipse mouse_x, mouse_y, 5, 5
  @points.each do |x|
    fill 0, 255, 0
    ellipse x.x, x.y, 3, 3
  end
end

def mouse_pressed
  puts "ADDED"
  @points << Vec2D.new(mouse_x, mouse_y)
end

def key_released
  puts "[" + (@points.map{|point| "Vec2D.new(#{point.x}, #{point.y})"}.join ",") + "]"
end
