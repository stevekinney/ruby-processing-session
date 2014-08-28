class Monster
  def initialize(x, y)
    @x = x
    @y = y
  end

  def left_hand
    i = 0

    while i < 200
      bezier mouse_x-300-(i/2.0), mouse_y+40+i, 410, 20,  40, 400, 240-(i/16.0), 300+(i/8.0)
      i += 20
    end
  end

  def right_hand
    i = 0

    while i < 200
      bezier mouse_x+100-(i/2.0), mouse_y+40+i, 510, -20, 440, 460, 240-(i/16.0), 300+(i/8.0)
      i += 20
    end
  end

  def left_eye
    outside_radius = 27
    inside_radius = 3

    num_points = map mouse_x, 0, 600, 6, 60
    angle = 0.0;
    angle_step = 180.0/num_points;

    begin_shape TRIANGLE_STRIP
      i = 0
      while i <= num_points
        px = 265 + cos(angle.radians) * outside_radius
        py = 295 + sin(angle.radians) * outside_radius
        angle += angle_step
        vertex px, py
        px = 265 + cos(angle.radians) * inside_radius
        py = 295 + sin(angle.radians) * inside_radius
        vertex px, py
        angle += angle_step
        i += 1
      end
    endShape

  end

  def right_eye
    outsideRadius = 20
    insideRadius = 5

    num_points = map mouse_x, 0, 600, 6, 60
    angle = 0.0;
    angle_step = 180.0/num_points;

    begin_shape TRIANGLE_STRIP
      i = 0
      while i <= num_points
        px = 340 + cos(angle.radians) * outsideRadius
        py = 295 + sin(angle.radians) * outsideRadius
        angle += angle_step
        vertex px, py
        px = 340 + cos(angle.radians) * insideRadius
        py = 295 + sin(angle.radians) * insideRadius
        vertex px, py
        angle += angle_step
        i += 1
      end
    endShape
  end

  def mouth
    rect 300, 340, 100, 20
  end

  def body
    arc 300, 350, 200, 200, PI, TWO_PI
  end

  def draw
    left_hand
    right_hand

    body

    left_eye
    right_eye
    mouth
  end

end

def setup
  size 600, 600
  background 255, 255, 255

  smooth

  ellipse_mode CENTER
  rect_mode CENTER

  @monster = Monster.new(400, 500)
end

def draw
  background 255, 255, 255

  @monster.draw
end

