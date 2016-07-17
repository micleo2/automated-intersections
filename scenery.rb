module Scenery

  def Scenery.draw_road(road_width)
    $app.fill 160, 160, 160
    $app.rect_mode 3
    $app.no_stroke
    $app.rect $app.width/2, $app.height/2, $app.width, road_width
    $app.rect $app.width/2, $app.height/2, road_width, $app.height
  end

  def Scenery.draw_lanes
    width, height = $app.width, $app.height
    padding = 55
    lane_width = 3
    lane_height = 23
    dist_to_middle = 100

    $app.no_stroke
    $app.fill 255, 255, 0
    draw_vertical_rect = lambda {|y| $app.rect width/2, y, lane_width, lane_height}
    draw_horizontal_rect = lambda {|x| $app.rect x, height/2, lane_height, lane_width}

    ((height/2 + dist_to_middle)..(height + lane_height)).step(padding).each &draw_vertical_rect
    (-lane_height..(height/2 - dist_to_middle)).step(padding).each &draw_vertical_rect
    #NOW FOR HORIZONTAL LANES
    (-lane_height..(width/2 - dist_to_middle)).step(padding).each &draw_horizontal_rect
    ((width/2 + dist_to_middle)..(width + 23)).step(padding).each &draw_horizontal_rect

  end
end
