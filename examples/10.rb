class Circle

  attr_accessor :x, :y, :width, :height

  def initialize(x, y, width, height)
    @x = x
    @y = y
    @width = width
    @height = height
  end

  def draw
    fill 255, 0, 0
    stroke 255
    stroke_width 5
    ellipse x, y, width, height
  end

  def move_right
    # Normally I'd use a setter method for x,
    # but jRuby didn't seem to like that.
    @x = x + 1
  end

end

def setup
  size 480, 480
  background 0

  smooth

  ellipse_mode CENTER
  rect_mode CENTER

  @circle = Circle.new 240, 240, 100, 100
end

def draw
  background 0
  @circle.draw
  @circle.move_right
end

def key_pressed; end

def mouse_pressed; end

def mouse_dragged; end

def mouse_released; end
