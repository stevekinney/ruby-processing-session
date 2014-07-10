def setup
  size 480, 480
  background 0

  smooth

  ellipse_mode CENTER
  rect_mode CENTER

  @x = 0
  @y = 240
end

def draw
  background 0
  fill 255, 0, 0
  stroke 255
  stroke_width 5

  ellipse @x, @y, 100, 100

  if @x < 480
    @x += 1
  end
end

def key_pressed
  warn "Key pressed: #{key.inspect}"
  @x = 0
end
