#the system is a homogenus composition of DriverAgents
require_relative "shape_factory"
require_relative "math_util"
class DriverAgent
  include Processing::Proxy
  attr_accessor :agent, :path, :castbox, :hitbox

  def initialize(agent, path)
    @agent = agent
    @path = path
    @castbox = ShapeFactory.create_triangle
    @hitbox = ShapeFactory.create_rectangle
    @is_braking = false
  end

  def update
    @path.adjust_to @agent
    if @path.reached_destination? @agent
      @agent.steering.arrive @path.current_point, 100
    else
      @agent.steering.seek @path.current_point
    end
    @agent.steering.update
    @agent.time_in_intersection += 1
    ang = Math::atan2 @agent.velocity.x, -@agent.velocity.y
    [@castbox, @hitbox].each{|b| b.align_to ang}
  end

  def react_to(other_cars)
    cars = other_cars.select{|c| c.object_id != self.object_id}
    cars.each do |c|
      if will_collide? c
        if @agent.time_in_intersection <= c.agent.time_in_intersection
          brake_from c
          @is_braking = true
          # puts "GONNA HIT SOMETHING"
        else
          @is_braking = false
        end
      end
    end
  end

  def brake_from(other)
    @agent.velocity *= 0.8
  end

  def will_collide?(other)
    dist = (@agent.position - other.agent.position).mag
    if @path.index.zero?
      dist < 60
    else
      MathUtil::polygons_intersect? other.castbox.transform_by(other.agent.position.x, other.agent.position.y), @castbox.transform_by(@agent.position.x, @agent.position.y)
    end
  end

  def draw
    @agent.draw
    stroke 255, 0, 0
    stroke_weight 3
    @castbox.verticies.each{|v| point v.x + @agent.position.x, v.y + @agent.position.y}
    stroke 0, 0, 255
    @hitbox.verticies.each{|v| point v.x + @agent.position.x, v.y + @agent.position.y}
  end
end
