module MathUtil
  include Processing::Proxy

  def MathUtil::polygons_intersect?(a, b)
    polygons = [a, b]
    minA = maxA = projected = i = i1 = j = minB = maxB = nil
    polygons.each do |polygon|
      verts = polygon.verticies
      verts.length.times do |i|
        i2 = (i + 1) % verts.length
        p1 = verts[i]
        p2 = verts[i2]
        normal = Vec2D.new(p2.y - p1.y, p1.x - p2.x)
        minA = maxA = nil
        #for each vertex in the first shape, project it onto the line perpendicular to the edge
        # and keep track of the min and max of these values
        a.verticies.each do |v|
          #a[j] = v
          projected = normal.x * v.x + normal.y * v.y
          if (minA.nil? || projected < minA)
            minA = projected
          end
          if (maxA.nil? || projected > maxA)
            maxA = projected
          end
        end
        #now do the other shape
        minB = maxB = nil
        b.verticies.each do |v|
          projected = normal.x * v.x + normal.y * v.y
          if (minB.nil? || projected < minB)
            minB = projected
          end
          if (maxB.nil? || projected > maxB)
            maxB = projected
          end
        end
        if maxA < minB || maxB < minA
          return false
        end
      end
    end
    return true
  end


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
