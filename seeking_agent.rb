require_relative "behavior_chooser"

class SeekingAgent
  include Processing::Proxy

  attr_accessor :position, :velocity, :max_velocity, :mass, :steering, :time_in_intersection

  def initialize(position, max)
    @position = position
    @velocity = Vec2D.new 0, 0
    @max_velocity = max
    @mass = 50
    @img = load_image "topdown_car.png"
    @steering = BehaviorChooser.new self
    @time_in_intersection = 0
  end

  def react_to(other_cars)
    cars = other_cars.select{|c| c.object_id != self.object_id}
    cars.each do |c|
      if will_collide? c
        puts "CRASH COURSE"
        if @time_in_intersection <= c.time_in_intersection
          @velocity *= 0.8
        end
      end
    end
  end

  def will_collide?(other)
    dist = (@position - other.position).mag
    puts "the distance is #{dist}"
    dist < 90
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
