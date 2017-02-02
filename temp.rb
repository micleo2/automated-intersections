def collide?(other)
   # test separation axes of current polygon
   @vertices.drop(1).each.with_index do |v1, i|
     v0 = @vertices[i-1]
     edge = Vec2D.new((v1.x - v0.x), (v1.y - v0.y));
     axis = MathUtil::perpendicular edge
     return false if separatedByAxis axis, other
   end
   # test separation axes of other polygon
   other.vertices.drop(1).each.with_index do |v1, i|
     v0 = other.vertices[i-1]
     edge = Vec2D.new((v1.x - v0.x), (v1.y - v0.y));
     axis = MathUtil::perpendicular edge
     return false if separatedByAxis axis, other
   end
   true
 end

def calculateInterval(axis)
  @min = @max = (@verticies.first.dot axis)
  @vertices.drop(1).each do |v|
    d = v.dot axis
    @min = d if d < @min
    @max = d if d > @max
  end
end

def intervalsSeparated(mina, maxa, minb, maxb)
  (mina > maxb) || (minb > maxa)
end

def separatedByAxis(axis, poly)
  calculateInterval axis
  poly.calculateInterval axis
  intervalsSeparated @min, @max, poly.min, poly.max
end
