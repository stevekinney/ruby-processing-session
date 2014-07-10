def setup
  size 480, 480
  background 0

  smooth

  ellipse_mode CENTER
  rect_mode CENTER
end

def draw
  background 0
  fill 255, 0, 0
  stroke 255
  stroke_width 5
  ellipse mouse_x, mouse_y, 100, 100
end
