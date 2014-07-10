def setup
  size 480, 480
  background 0

  smooth
end

def draw
  stroke 255
  stroke_width 5

  line pmouse_x, pmouse_y, mouse_x, mouse_y
end

def key_pressed
  warn "Key pressed: #{key}"
  if key == "x"
    background 0
  end
end
