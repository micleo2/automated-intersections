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
    @points.each.with_index do |n, i|
      if i < @index
        stroke 0
      elsif i == @index
        stroke 0, 255, 0
      else
        stroke 255, 0, 0
      end
      stroke_weight 5
      point n.x, n.y
      stroke_weight 1
      stroke 180, 180, 180
      no_fill
      ellipse n.x, n.y, @dist*2, @dist*2
    end
  end

  def adjust_to(agent)
    if (agent.position - current_point).mag < @dist && @index != @points.length-1
      @index +=1
    end
  end

  def reached_destination?
    @index == (@points.length-1)
  end

  def +(other_route)
  end

  def <<(node)
    add_point node
  end

  def Route.from_bezier(curve, accuracy, dist = 25)
    accuracy -= 1
    Route.new ((0..accuracy).map{|n| n.to_f / accuracy}.map{|x| curve.at_x x}.to_a), dist
  end

end
