module MathUtil
  include Processing::Proxy

  class Line
    attr_accessor :first_point, :second_point
    def initialize(first_point, second_point)
      @first_point = first_point
      @second_point = second_point
    end

    def slope
      (@second_point.y - @first_point.y) / (@second_point.x - @first_point.x)
    end

    def draw
      $app.stroke 0
      $app.stroke_weight 1
      $app.line @first_point.x, @first_point.y, @second_point.x, @second_point.y
    end

    def get_abc
      a = @second_point.y - @first_point.y
      b = @first_point.x - @second_point.x
      c = a * @first_point.x + b * @first_point.y
      [a, b, c]
    end
    #returns Nil if no intersection, else returns Vec2D
    def point_of_intersection(other)
      a1, b1, c1 = get_abc
      a2, b2, c2 = other.get_abc
      delta = a1*b2 - a2*b1
      return nil if delta.zero?
      Vec2D.new((b2*c1 - b1*c2) / delta, (a1*c2 - a2*c1) / delta)
    end

    def Line.from_coordinates(x0, y0, x1, y1)
      Line.new(Vec2D.new(x0, y0), Vec2D.new(x1, y1))
    end
  end
end
