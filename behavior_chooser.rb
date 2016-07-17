class BehaviorChooser
  include Processing::Proxy

  def initialize(agent)
    @host = agent
    @steer_force = Vec2D.new 0, 0
  end

  def seek(target)
    desired_velocity = (target - @host.position).normalize * @host.max_velocity
    @steer_force = desired_velocity - @host.velocity
  end

  def update
    max_force = 2

    @steer_force.set_mag(max_force){@steer_force.mag > max_force}
    @steer_force = @steer_force / @host.mass

    @host.velocity = @host.velocity + @steer_force
    @host.velocity.set_mag(@host.max_velocity){@host.velocity.mag > @host.max_velocity}
    @host.position += @host.velocity
  end
end
