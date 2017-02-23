class Shape
  include Processing::Proxy

  attr_accessor :verticies, :old_theta

  def initialize
    @verticies = []
    @old_theta = nil
  end

  def transform_by!(x, y)
    @verticies.map! do |v|
      x_prime = v.x + x
      y_prime = v.y + y
      Vec2D.new x_prime, y_prime
    end
    self
  end

  def transform_by(x, y)
    ret = Shape.new
    ret.old_theta = @old_theta
    ret.verticies = @verticies.map do |v|
      x_prime = v.x + x
      y_prime = v.y + y
      Vec2D.new x_prime, y_prime
    end
    ret
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
    self
  end

  def draw
    stroke_weight 0.5
    begin_shape
    no_fill
    @verticies.each{|v| vertex(v.x, v.y)}
    end_shape CLOSE
  end

  def fill_draw(r, g, b)
    stroke_weight 0.5
    begin_shape
    fill r, g, b
    @verticies.each{|v| vertex(v.x, v.y)}
    end_shape CLOSE
  end
end
