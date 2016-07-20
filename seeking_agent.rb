require_relative "behavior_chooser"

class SeekingAgent
  include Processing::Proxy

  attr_accessor :position, :velocity, :max_velocity, :mass, :steering

  def initialize(position, max)
    @position = position
    @velocity = Vec2D.new 0, 0
    @max_velocity = max
    @mass = 50
    @img = load_image "topdown_car.png"
    @steering = BehaviorChooser.new self
  end

  def update(target, dist)
    # @steering.arrive target, dist
    # @steering.seek target
    @steering.update
  end

  def draw()
    push_matrix
    translate @position.x, @position.y
    rotate Math::atan2 @velocity.y, @velocity.x
    image_mode CENTER
    scale 0.04
    image @img, 0, 0
    pop_matrix
  end
end
