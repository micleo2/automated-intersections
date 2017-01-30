#the system is a homogenus composition of DriverAgents
require_relative "shape"

class DriverAgent
  include Processing::Proxy
  attr_accessor :agent, :path, :castbox

  def initialize(agent, path)
    @agent = agent
    @path = path
    @castbox = Shape.new
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
    @castbox.align_to ang
  end

  def react_to(other_cars)
    cars = other_cars.select{|c| c.object_id != self.object_id}
    cars.each do |c|
      if will_collide? c
        if @agent.time_in_intersection <= c.agent.time_in_intersection
          @agent.velocity *= 0.76
          @is_braking = true
        else
          @is_braking = false
        end
      end
    end
  end

  def will_collide?(other)
    dist = (@agent.position - other.agent.position).mag
    dist < 65
  end

  def draw
    @agent.draw
    stroke 255, 0, 0
    stroke_weight 3
    @castbox.verticies.each{|v| point v.x + @agent.position.x, v.y + @agent.position.y}
  end
end
