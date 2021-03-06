#the system is a homogenus composition of DriverAgents
require_relative "shape_factory"
require_relative "math_util"
require_relative "config"

class DriverAgent
  include Processing::Proxy
  attr_accessor :agent, :path, :castbox, :hitbox, :collide_box, :stats, :position_projection

  def initialize(agent, path, stats=nil)
    @agent = agent
    @path = path
    @castbox = ShapeFactory.create_triangle
    @hitbox = ShapeFactory.create_rectangle
    @collide_box = ShapeFactory.create_bounds
    @is_braking = false
    @stats = stats
    @position_projection = MathUtil::Line.from_coordinates(0, 0, 0, 0)
  end

  def update
    @path.adjust_to @agent
    @agent.steering.seek @path.current_point
    @agent.steering.update
    @agent.time_in_intersection += 1
    c = 50
    @position_projection = MathUtil::Line.from_coordinates(0, 0, @agent.velocity.x * c, @agent.velocity.y * c)
    # slope = @position_projection.second_point - @position_projection.first_point
    # slope.normalize!
    # @position_projection.first_point += slope * 20
    @hitbox = ShapeFactory.rect_from_line @position_projection
    ang = Math::atan2 @agent.velocity.x, -@agent.velocity.y
    [@castbox, @collide_box].each{|b| b.align_to ang}
  end

  def react_to(other_cars)
    cars = other_cars.select{|c| c.object_id != self.object_id}
    num_collided = 0
    cars.each do |c|
      if will_collide? c
        if @agent.time_in_intersection <= c.agent.time_in_intersection
          brake_from c
          @is_braking = true
          num_collided += 1
        else
          @is_braking = false
        end
      end
    end

    new_colliding = cars.any? {|c| crashed_into? c}
    if new_colliding
      if Config::debug?
        stroke 0, 0, 0
        @collide_box.transform_by(@agent.position.x, @agent.position.y).draw
      end
    end
    on_collide_exit if (@colliding && !new_colliding)
    on_collide_enter if (!@colliding && new_colliding)
    @colliding = new_colliding
    @is_braking = false if num_collided == 0
    if !@is_braking
      @agent.max_velocity = 2
    end
  end

  def on_collide_exit
    @stats.crashes += 1
  end

  def on_collide_enter
    save_frame("screenshots/" + MathUtil::unique_name + ".png") if MathUtil::should_save_frame?
  end

  def brake_from(other)
    factor = 0.8
    avg_point = MathUtil::average_point other.hitbox.transform_by(other.agent.position.x, other.agent.position.y), @castbox.transform_by(@agent.position.x, @agent.position.y)
    dist = @path.current_point - other.path.current_point
    if (@agent.position - avg_point).mag - (other.agent.position - avg_point).mag < -5
      factor = 1.2
      @agent.max_velocity = 2.4
    else
      @agent.max_velocity = 2
    end
    @agent.velocity *= factor
    if Config::debug?
      stroke 0, 0, 255
      # other.hitbox.verticies.each{|v| point v.x + other.agent.position.x, v.y + other.agent.position.y}
      other.hitbox.transform_by(other.agent.position.x, other.agent.position.y).draw
      stroke_weight 1
      line @agent.position.x, @agent.position.y, other.agent.position.x, other.agent.position.y
      fill 0
      if factor < 1
        text "braking...", @agent.position.x-20, @agent.position.y + 15
      else
        text "accelerating", @agent.position.x-20, @agent.position.y + 15
      end
      stroke 0, 0, 255
      no_fill
      ellipse avg_point.x, avg_point.y, 5, 5
    end
  end

  def crashed_into?(other)
    dist = (@agent.position - other.agent.position).mag
    if dist < 60
      return MathUtil::polygons_intersect? other.collide_box.transform_by(other.agent.position.x, other.agent.position.y), @collide_box.transform_by(@agent.position.x, @agent.position.y)
    end
    false
  end

  def will_collide?(other)
    dist = (@agent.position - other.agent.position).mag
    if @path.index.zero?
      dist < 60
    else
      MathUtil::polygons_intersect? other.hitbox.transform_by(other.agent.position.x, other.agent.position.y), @castbox.transform_by(@agent.position.x, @agent.position.y)
    end
    # dist = (@agent.position - other.agent.position).mag
    # dist < 65
  end

  def draw
    @agent.draw
    if Config.debug?
      text_size 10
      fill 0
      text "#{@agent.time_in_intersection}", @agent.position.x, @agent.position.y - 15
      if @is_braking
        stroke 255, 0, 0
        stroke_weight 3
        # @castbox.verticies.each{|v| point v.x + @agent.position.x, v.y + @agent.position.y}
        @castbox.transform_by(@agent.position.x, @agent.position.y).draw
      end
      if @colliding
        fill 255, 0, 0
        text "crash", @agent.position.x+20, @agent.position.y + 15
      end
    end
  end
end
