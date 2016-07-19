class BezierCurve
  include Processing::Proxy

  def initialize(p0, p1, p2)
    @p0 = p0
    @p1 = p1
    @p2 = p2
  end

  def at_x(t)
    (@p0 * (1-t) ** 2) + (@p1 * 2 * (1-t) * t) + (@p2 * t ** 2)
  end
end
