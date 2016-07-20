class BehaviorChooser
  include Processing::Proxy
  attr_accessor :steer_force

  def initialize(agent)
    @host = agent
    @steer_force = Vec2D.new 0, 0
  end

  def seek(target)
    desired_velocity = (target - @host.position)#.normalize * @host.max_velocity
    @steer_force += desired_velocity - @host.velocity
    max_force = 6
    @steer_force.set_mag(max_force){@steer_force.mag > max_force}
    @steer_force = @steer_force / @host.mass
  end

  def arrive(target, slow_radius)
    dist = (target - @host.position).mag
    if dist < slow_radius
      desired_velocity = target - @host.position
      desired_velocity = desired_velocity.normalize * @host.max_velocity * (dist / slow_radius)
      @steer_force = desired_velocity - @host.velocity
    else
      self.seek target
    end
  end

  def avoid(target, see_ahead)
    predicted = @host.position + @host.velocity.normalize * see_ahead
    if yield predicted
      @steer_force += (@host.position - target).normalize * 3
    end
  end

  def update
    @host.velocity = @host.velocity + @steer_force
    @host.velocity.set_mag(@host.max_velocity){@host.velocity.mag > @host.max_velocity}
    @host.position += @host.velocity
  end
end
