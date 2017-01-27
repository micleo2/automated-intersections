require_relative "bezier_curve"

class CarSpawner
  attr_accessor :critical_points
  def initialize(cars, dist_to_middle, w, h)
    @cars = cars
    @dist_to_middle = dist_to_middle
    @critical_points = []
    @critical_points << [Vec2D.new(w/2 + 35, h/2 + 105), Vec2D.new(w/2 + 35, h/2 - 105)]
    @critical_points << [Vec2D.new(w/2 + 115, h/2 - 40), Vec2D.new(w/2 - 115, h/2 - 40)]
    @critical_points << [Vec2D.new(w/2 - 90, h/2 + 39), Vec2D.new(w/2 + 130, h/2 + 39)]
    @critical_points << [Vec2D.new(w/2 - 34, h/2 - 105), Vec2D.new(w/2 - 34, h/2 + 105)]
    @w = w
    @h = h
  end
  #have pairs of coords, which mean [entry, exit]
  #be able to design a route from an [entry, exit] pair
  # @car = SeekingAgent.new Vec2D.new(width/2 + 370, height/2 - 40), 2
  # @opath = Route.from_bezier BezierCurve.new(Vec2D.new(width/2 + 115, height/2 - 40), Vec2D.new(width/2, height/2 - 40), Vec2D.new(width/2 - 115, height/2 - 40)), 10
  def rand_critical
    @critical_points.sample
  end

  def create_bezier(entry, exit)
    control_point = Vec2D.new(@w/2, @h/2)
    if is_line?(entry, exit)
      # dir = (entry - exit).normalize!
      control_point = (entry + exit) / 2
    end
    BezierCurve.new(entry, control_point, exit)
  end

  def is_line?(entry, exit)
    entry.y == exit.y || entry.x == exit.x
  end

  def create_location(entry, exit)
    dist = (entry - exit).normalize!
    entry + (dist*200)
  end

  def pad_path(p)
    target_points = p.points
    exit, entry = target_points.last, target_points.first
    dist = (exit - entry).normalize!
    dist *= 200;
    end_point = Vec2D.new(exit.x + dist.x, exit.y + dist.y)
    p.points << end_point
    p
  end

  def create_car
    curvature = 45
    points = rand_critical
    bezier = create_bezier(*points)
    c = SeekingAgent.new(create_location(*points), 2)
    pth = Route.from_bezier bezier, 10
    pad_path pth
    DriverAgent.new(c, pth)
  end
end
