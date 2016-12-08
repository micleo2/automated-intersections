class BezierCurve
  include Processing::Proxy

  def initialize(p0, p1, p2)
    @p0 = p0
    @p1 = p1
    @p2 = p2
  end

  def at_x(t)
    (@p0 * ((1-t) ** 2)) + (@p1 * 2 * (1-t) * t) + (@p2 * (t ** 2))
  end

  def draw
    no_fill
    stroke_weight 3
    begin_shape
    vertex @p0.x, @p0.y
    quadratic_vertex @p1.x, @p1.y, @p2.x, @p2.y
    end_shape
  end
end
