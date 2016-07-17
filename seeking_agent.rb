class SeekingAgent
  include Processing::Proxy

  attr_accessor :position, :target, :max_speed

  def initialize(position, target, vec_class)
    @position = position
    @target = target
    @VecClass = vec_class
    @max_speed = 2
    @mass = 50
    @velocity = vec_class.new 0, 0
    @img = load_image "topdown_car.png"
  end

  def update
    max_force = 100
    desired_velocity = (@target - @position).normalize * @max_speed
    steering = desired_velocity - @velocity
    steering.set_mag(@max_speed){steering.mag > @max_speed}
    steering = steering / @mass

    @velocity = @velocity + steering
    @velocity.set_mag(@max_speed){@velocity.mag > @max_speed}
    @position += @velocity
  end
  #3 = CENTER
  def draw(sketch)
    push_matrix
    translate @position.x, @position.y
    rotate Math::atan2 @velocity.y, @velocity.x
    image_mode CENTER
    scale 0.04
    image @img, 0, 0
    pop_matrix
  end
end
