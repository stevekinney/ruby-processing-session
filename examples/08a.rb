def setup
  size 480, 480
  background 0

  smooth

  ellipse_mode CENTER
  rect_mode CENTER

  @x = 240
  @y = 240
end

def draw
  background 0
  fill 255, 0, 0
  stroke 255
  stroke_width 5

  ellipse @x, @y, 100, 100
end

def key_pressed
  if key == CODED
    warn "Key pressed with code: #{keyCode}."
  else
    warn "Key pressed: #{key.inspect}"
  end
end

def mouse_pressed
  warn "The mouse was pressed at #{mouse_x}, #{mouse_y}."
end

def mouse_dragged
  warn "Dragging mouse. (#{mouse_x}, #{mouse_y})"
end

def mouse_released
  warn "The mouse was released at #{mouse_x}, #{mouse_y}."
end
