class Button
  include Processing::Proxy
  attr_accessor :width, :height, :message

  def initialize(x, y, w, h, m)
    @width = w
    @height = h
    @message = m
    @x = x
    @y = y
  end

  def hovered?
    return (mouse_x >= @x && mouse_x <= @x+@width && mouse_y >= @y && mouse_y <= @y+@height)
  end

  def draw
    if hovered?
      fill 51
    else
      fill 0
    end
    rect_mode CENTER
    rect @x + @width/2, @y + @height/2, @width, @height
    fill 255
    text_size 20
    text(@message, @x + @width/3, @y + @height/2.5)
  end

  def on_click
    if hovered?
      yield
    end
  end
end
