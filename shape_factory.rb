require_relative "shape"
class ShapeFactory
  class << self
    def create_triangle
      s = Shape.new
      s.verticies << Vec2D.new(-35, -70)
      s.verticies << Vec2D.new(35, -70)
      s.verticies << Vec2D.new(0, 10)
      s
    end

    def create_rectangle
      s = Shape.new
      w = 30
      s.verticies << Vec2D.new(-w/2, -35)
      s.verticies << Vec2D.new(w/2, -35)
      s.verticies << Vec2D.new(w/2, 15)
      s.verticies << Vec2D.new(-w/2, 15)
      s
    end
  end
end
