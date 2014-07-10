def setup
  size 480, 480

  smooth
  # The frame rate (like a movie) is set to 30 frames per second
  frame_rate 30

  @poops = []
end

def draw
  # draw a white background
  background 255

  # Set ellipses and rects to CENTER mode
  ellipse_mode CENTER
  rect_mode CENTER

  @poops.each(&:draw)

  # Draw Zoog's body
  stroke 0
  fill 150
  rect mouse_x, mouse_y, 20, 100

  # Draw Zoog's head
  stroke 0
  fill 255
  ellipse mouse_x, mouse_y - 30, 60, 60

  # Draw Zoog's eyes
  # The eye color is determined by mouse location.
  fill mouse_x, 0, mouse_y
  ellipse mouse_x - 19, mouse_y - 30, 16, 32
  ellipse mouse_x + 19, mouse_y - 30, 16, 32

  # Draw Zoog's legs
  stroke 0
  # The legs are drawn according to where the mouse is now and where it used to be.
  line mouse_x - 10, mouse_y + 50, pmouse_x - 10, pmouse_y + 60
  line mouse_x + 10, mouse_y + 50, pmouse_x + 10, pmouse_y + 60
end

def mouse_pressed
  warn 'Take me to your leader!'
  @poops << Poop.new(mouse_x, mouse_y + 50)
end

class Poop
  def initialize(x, y)
    @x = x
    @y = y
    draw
  end

  def fall
    if @y <= 480
      @y += 5
    end
  end

  def draw
    warn 'I poop on you!'
    fill 139, 69, 19
    ellipse @x, @y, 10, 25
    fall
  end
end
