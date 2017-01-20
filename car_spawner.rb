require_relative "bezier_curve"
# require_relative ""
# load_libraries :vecmath
class CarSpawner
  attr_accessor :critical_points
  def initialize(cars, dist_to_middle, w, h)
    @cars = cars
    @dist_to_middle = dist_to_middle
    @critical_points = []
    @critical_points << [Vec2D.new(w/2 + 35, h/2 + 105), Vec2D.new(w/2 + 35, h/2 - 105)]
    # @critical_points << [entry, exit]
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
    BezierCurve.new(entry, Vec2D.new(@w/2 + 35, @h/2), exit)
  end

  def create_location(entry, exit)
    Vec2D.new(@w/2 + 35, @h/2 + 305)
  end

  def create_car(w, h)
    curvature = 45
    points = rand_critical
    bezier = create_bezier(*rand_critical)
    c = SeekingAgent.new(create_location(*points), 2)
    pth = Route.from_bezier bezier, 10
    DriverAgent.new(c, pth)
  end
end
