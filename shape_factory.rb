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

    def create_cast
      s = Shape.new
      s.verticies << Vec2D.new(-35, -70)
      s.verticies << Vec2D.new(35, -70)
      s.verticies << Vec2D.new(11, 7)
      s.verticies << Vec2D.new(-11, 7)
      s
    end

    def create_semi_circle
      s = Shape.new
      w = 40
      s.verticies << Vec2D.new(w, 0)
      s.verticies << Vec2D.new(-w, 0)
      s.verticies << Vec2D.new(-w, -40)
      s.verticies << Vec2D.new(-w*0.6, -75)
      s.verticies << Vec2D.new(w*0.6, -75)
      s.verticies << Vec2D.new(w, -40)
      s
    end
  end
end
