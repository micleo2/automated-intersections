require_relative "math_util"

class Shape
  include Processing::Proxy

  attr_accessor :verticies, :min, :max

  def initialize
    @verticies = []
    @old_theta = nil
    @min = nil
    @max = nil
  end

  def to_a
    @verticies.map{|v| [v.x, v.y]}
  end

  def transform_by(x, y)
    @verticies.map! do |v|
      x_prime = v.x + x
      y_prime = v.y + y
      Vec2D.new x_prime, y_prime
    end
    self
  end

  # x′=xcos(θ)−ysin(θ)
  # y′=xsin(θ)+ycos(θ)
  def rotate_by(theta)
    @verticies.map! do |v|
      x_prime = v.x*Math::cos(theta) - v.y*Math::sin(theta)
      y_prime = v.x*Math::sin(theta) + v.y*Math::cos(theta)
      Vec2D.new x_prime, y_prime
    end
  end

  def align_to(theta)
    if @old_theta.nil?
      @old_theta = theta
      rotate_by theta
    else
      diff = theta - @old_theta
      rotate_by diff
      @old_theta = theta
    end
  end

  def median_point
    @verticies.reduce(&:+) / @verticies.length
  end

  def intersecting?(other)
    true
  end

  def collide?(other)
     @verticies.drop(1).each.with_index do |v1, i|
       v0 = @verticies[i-1]
       edge = Vec2D.new((v1.x - v0.x), (v1.y - v0.y))
       axis = MathUtil::perpendicular edge
       return false if separatedByAxis axis, other
     end
     # test separation axes of other polygon
     other.verticies.drop(1).each.with_index do |v1, i|
       v0 = other.verticies[i-1]
       edge = Vec2D.new((v1.x - v0.x), (v1.y - v0.y));
       axis = MathUtil::perpendicular edge
       return false if separatedByAxis axis, other
     end
     true
   end

  def calculateInterval(axis)
    @min = @max = (@verticies.first.dot axis)
    @verticies.drop(1).each do |v|
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


  def draw
    stroke_weight 1
    begin_shape
    @verticies.each{|v| vertex(v.x, v.y)}
    end_shape CLOSE
  end
end
