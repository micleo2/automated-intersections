#the system is a homogenus composition of DriverAgents
class DriverAgent
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
  end

  def draw
    @agent.draw
    @path.draw
  end
end
