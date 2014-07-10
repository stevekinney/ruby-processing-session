class EmbarassedFace

  attr_accessor :x, :y, :width, :height

  def initialize(x, y, width, height)
    @x = x
    @y = y
    @width = width
    @height = height
  end

  def draw

    # Draw the face
    fill 255, 255, 0
    stroke 255
    stroke_width 2
    ellipse x, y, width, height

    # Draw the left eye
    fill 0
    no_stroke
    ellipse x - 20, y - 20, width / 8, height / 8

    # Draw the right eye
    # (We're using the same stroke and fill as before.)
    ellipse x + 20, y - 20, width / 8, height / 8

    # Draw the mouth
    rect x, y + 20, width * 0.8, height * 0.1

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

  @first_face = EmbarassedFace.new 120, 120, 100, 100
  @second_face = EmbarassedFace.new 360, 360, 100, 100
end

def draw
  background 0
  @first_face.draw
  @second_face.draw
end

def key_pressed; end

def mouse_pressed; end

def mouse_dragged; end

def mouse_released; end
