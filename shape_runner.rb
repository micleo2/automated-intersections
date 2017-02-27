require_relative "seeking_agent"
require_relative "scenery"
require_relative "route"
require_relative "bezier_curve"
require_relative "driver_agent"
require_relative "car_spawner"
require_relative "summary_statistics"
require_relative "button"
require_relative "config"

load_libraries :vecmath
$width = 750
$height = 900
def setup
  size $width, $height
  @all_cars = []
  @timer = 0
  @spawner = CarSpawner.new @all_cars, 100, $width, $height
  @stats = SummaryStatistics.new
  @exit_button = Button.new 50, 50, 100, 45, "EXIT"
  @debug_button = Button.new $width-150, 50, 100, 45, "#{Config::debug?}"
end

def mouse_pressed
  @exit_button.on_click do
    @stats.save_data
    exit()
  end
  @debug_button.on_click do
    Config::toggle
    @debug_button.message = "#{Config::debug?}"
  end
end

def draw
  @timer -= 1
  frame_rate 20
  background 255
  Scenery::draw_road 150
  Scenery::draw_lanes
  @all_cars.each(&:draw)
  @all_cars.each(&:update)
  @all_cars.delete_if do |c|
    if c.path.reached_destination? c.agent
      @stats.wait_times << c.agent.time_in_intersection
      true
    else
      false
    end
  end

  if @timer < 0
    car = @spawner.create_car
    car.stats = @stats
    @all_cars << car
    @timer = 45
  end
  @all_cars.each{|c| c.react_to @all_cars}
  [@exit_button, @debug_button].each(&:draw)

  if Config::debug?
    fill 0, 255, 0
    text "Average wait time: #{@stats.avg_time}", 15, $height - 150
    text "Crashes: #{@stats.crashes/2}", 15, $height - 100
    text "Cars serviced: #{@stats.wait_times.length}", 15, $height - 50
  end
end
