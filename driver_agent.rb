#the system is a homogenus composition of DriverAgents
class DriverAgent
  include Processing::Proxy
  attr_accessor :agent, :path

  def initialize(agent, path)
    @agent = agent
    @path = path
  end

  def update
    @path.adjust_to @agent
    if @path.reached_destination?
      @agent.steering.arrive @path.current_point, 100
    else
      @agent.steering.seek @path.current_point
    end
    @agent.steering.update
    @agent.time_in_intersection += 1
  end

  def react_to(other_cars)
    cars = other_cars.select{|c| c.object_id != self.object_id}
    cars.each do |c|
      if will_collide? c
        if @agent.time_in_intersection <= c.agent.time_in_intersection
          @agent.velocity *= 0.8
        end
      end
    end
  end

  def will_collide?(other)
    dist = (@agent.position - other.agent.position).mag
    # puts "the distance is #{dist}"
    dist < 50
  end

  def draw
    no_fill
    stroke 0, 0, 0
    ellipse *@agent.position, 100, 100
    @agent.draw
    # @path.draw
  end
end
