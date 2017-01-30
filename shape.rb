class Shape
  include Processing::Proxy

  attr_accessor :verticies

  def initialize
    @verticies = []
    @verticies << Vec2D.new(-35, -70)
    @verticies << Vec2D.new(35, -70)
    @verticies << Vec2D.new(0, 10)
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

  def draw
    stroke_weight 1
    begin_shape
    @verticies.each{|v| vertex(v.x, v.y)}
    end_shape CLOSE
  end
end
