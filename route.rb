class Route
  include Processing::Proxy
  attr_accessor :points

  def initialize(points, dist)
    @points = points
    @index = 0
    @dist = dist
  end

  def add_point(point)
    @points << point
  end

  def current_point
    @points[@index]
  end

  def draw
    @points.each do |n|
      stroke 0
      stroke_weight 5
      point n.x, n.y
    end
  end

  def adjust_to(agent)
    if (agent.position - current_point).mag < @dist && @index != @points.length-1
      @index +=1
    end
  end
end
