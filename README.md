# An Introduction to Ruby Processing

Basic Outline for the session:

- Get everything set up and installed
- Take a look at some samples
- Get comfortable with the anatomy of a sketch
- Draw some shapes
  - that change every frame
  - that react to the keyboard
  - that react to the mouse
- Draw some objects composed of multiple shapes
  - Use classes to encapsulate properties and data

## What is Processing?

- It's built on Java.
- It's for making art.
- It's built for non-programmer

## What is Ruby Processing?

It's Processing, but with Ruby (Duh.)

It was originally created by a [Jeremy Ashkenas][ja], who also created CoffeeScript, Backbone, and Underscore.js. Jeremy works for the [New York Times][nyt]. These days, it's maintained by [Martin Prout][mp].

[ja]: https://github.com/jashkenas
[nyt]: http://nytimes.com

There are some advantages and disadvantages to this and it probably makes sense to get them out of the way early. Ruby Processing is a wrapper around Processing, which is a wrapper around Java.

On one hand, it's Ruby and Ruby is great. On the other hand, it's mostly maintained by [one person][monkstone]. Most of the documentation and tutorials on the Internet are based on the Java version of Processing, but it's fairly simple to translate the everying into Ruby and it seemed a little unfair to dump an entirely new programming language on you today. Because, yea—Ruby is awesome.

Because Ruby Processing uses jRuby, you can't use any gems that rely on native C code. Right now, you can safely ignore this fact, but you may eventually run into it somewhere down the road. The other caveat of using jRuby is that each version of Ruby uses it's own set of gems, which means you can't call out to Ruby Processing from inside—let's say—a Rails app without a little bit of dancing. Again, that's not a problem for us at this point. Just sayin'.

If you're really intesested in some of the trials and tribulations of integrating Ruby Processing into a Rails app, [I know a guy who did a talk on that very topic a few years back][jc].

[jc]: http://www.confreaks.com/videos/9-mwrc2010-dynamic-generation-of-images-and-video-with-ruby-processing

There are some other variants out there. [John Resig][resig] of [jQuery][jquery] fame created [Processing.js][pjs] that let's you either work with processing in JavaScript or take your Processing Sketches (in Java) at display them on the web.

[contributors]: https://github.com/jashkenas/ruby-processing/graphs/contributors
[monkstone]: https://github.com/monkstone
[resig]: http://ejohn.org/
[jquery]: http://jquery.com
[pjs]: http://processingjs.org/

## Setup and Installation

Install [Processing 2][p2dl].

[p2dl]: https://processing.org/download/?processing

Install jRuby. You don't *need* jRuby, but then you have to use the `--nojruby` flag every time you want to run a sketch. (jRuby used to come bundled with Ruby Processing, [but that's not the case anymore][faq].)  

[faq]: https://github.com/jashkenas/ruby-processing/wiki/FAQs

``` sh
rvm install jruby
```

Switch to jRuby. We probably don't want to use jRuby as our default Ruby, so you'll have to switch over to it whenever you open up a new terminal window or tab.

``` sh
rvm use jruby
```

Install Ruby Processing.

``` sh
gem install ruby-processing
```

Make sure you have `wget` installed.

``` sh
brew install wget
```

Install `jruby-complete` to get the necessary libraries.

``` sh
install_jruby_complete
```

Run this in the shell in order to let Ruby Processing know where Processing's Java runtime is installed.

``` sh
echo PROCESSING_ROOT: "/Applications/Processing.app/Contents/Java" > ~/.rp5rc
```

(**Note**: If you're having trouble getting everything set up, don't worry. I've built in some points early on where I'll stop talking for a bit and I'll be able to come over and help you get straightened out.)

## Usage

### Samples

`rp5 unpack samples` will download a bunch of samples to show you how Ruby Processing works.

### Commands

- `rp5 run [sketch.rb]` will run your sketch.
- `rp5 watch [sketch.rb]` will run your code and reload it as you make changes. This will help you iterate, with less friction. (This is probably the one you'll be using the most.)
- `rp5 live [sketch.rb]` will load up your sketch and drop you into `irb`.

## Anatomy of a Sketch

- `setup` runs at the beginning
- `draw` runs in an infinite loop as fast as it possibly can until it hits an `exit`.

These are technically optional. If you omit these two methods, Processing will set some sensible defaults and drop you into the draw loop.

This is a valid Ruby Processing sketch (`01.rb`):

``` rb
ellipse 50, 50, 80, 80
```

Here is another one with the basic structure that we're going to be using from this point forward (`02.rb`):

``` rb
def setup
  size 480, 480
  smooth
end

def draw
  ellipse mouse_x, mouse_y, 80, 80
end
```

You'll notice a bunch of variables and methods that we didn't define: `mouse_x`, `mouse_y`, `size`, `ellipse`, etc. These come free with Processing and you can find out more about them in the [Processing API Reference][docs]. We're going to cover a bunch of these shortly.

(**Question**: Why are we getting a ton of circles? Shouldn't the circle be moving along with the mouse?)

[docs]: http://processing.org/reference/

### Tasting Notes

- `[0,0]` is in the top-left corner (as opposed to math class, where it's usually in the lower-left corner or the center).
- It's more of a declarative thing as opposed to object oriented. (This will become a little more clear when we look at stroke and fill properties.)
- Declare an instance variable for anything you need to exist between methods (just like you would in a regular Ruby class).
- You can use any Ruby construct you want (e.g. Objects, Arrays, Hashes, Enumerable).

### Some Basic Setup Optons

- `background` lets you set a background color using RGB values. ([Here is a list of RBG codes for some of your favorite colors.][rgb])
- `smooth` will turn on anti-aliasing.
- `ellipse_mode` and `rect_mode` can be set to `CENTER`. This basically lets you define where a shape should be located by its center rather than its top-left corner.

[rgb]: http://www.tayloredmktg.com/rgb/

## Ruby Processing Primitives

(**Together:** Let's set up a scratch pad and use `rp5 watch` to play with each of these primitives.)

### Line

A line takes four arguments: the coordinates for the x- and y-axis for the starting point of the line and the coordinates for the end of the line.

``` rb
line x1, y1, x2, y2 # Syntax
line 30, 20, 85, 75 # Example
```

### Ellipse

Ellipse is a fancy name for a circle or oval. It takes four arguments: the x- and y-axis of its origin along with its width and height. By default, the origin is the top-left corner of the ellipse, by you can overide this by declaring `ellipse_mode = CENTER` in your setup.

``` rb
ellipse x, y, width, height # Syntax
ellipse 56, 46, 55, 55 # Example
```

### Triangle

Pretty self explanatory. The triangle primitive takes six arguments: the x- and y-axis of each of the three points.

``` rb
triangle x1, y1, x2, y2, x3, y3 # Syntax
triangle 30, 75, 58, 20, 86, 75 # Example
```

### Quadrilateral

Your classic four-sided shape. Simply declare the x- and y-axes for each of the four points. (Are you sensing a pattern here?)

``` rb
quad x1, y1, x2, y2, x3, y3, x4, y4 # Syntax
quad 38, 31, 86, 20, 69, 63, 30, 76 # Example
```

### Rectangle

If you're not aiming to build a trapezoid or a parallelogram, you can just use this primitive to make a rectangle or square. It has a syntax similar to the ellipse and its origin point can be overridden (just like the ellipse) by using `rect_mode = CENTER`.

``` rb
rect x, y, width, height # Syntax
rect 56, 46, 55, 55 # Example
```

## Styling Your Shapes

- `fill` takes RGB values and sets the inside color of the shape.
- `stroke` takes an RGB values and changes the color of the border.
- `stroke_width` takes an integer and changes the width of the border.
- `no_fill` removes the fill.
- `no_stroke` removes the stroke.

We can see some of these in action in `03.rb`.

``` rb
# Setup ommitted

def draw
  background 0
  fill 255, 0, 0
  stroke 255
  stroke_width 5
  ellipse mouse_x, mouse_y, 100, 100
end
```

(**Together**: Can you change some of the color settings on the of the shapes we just made?)

## Instance Variables

You should already know and love instance variables. It's the same basic concept from traditional Ruby programming. This is just a reminder to use them. Let's take a look at `04.rb`.

``` rb
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

  @x += 1
end
```

The coordinates of the ellipse are initialized in the `setup` method. `@x` is incremented at the end of each loop. The result is an ellipse that keeps moving to the right until it flies off into outer space.

`05.rb` is the same basic idea, but the `exit` method is sent when the ellipse reaches the end. `exit` causes your sketch to quit. It's completely useless in this case, but there are some applications of Ruby Processing where you might be creating an image or applying a filter to some video and you want the sketch to quit after it's saved the file.

## Event Hooks

- `key_pressed` fires every time you press down on a key.
- `key_typed` fires repeatedly as long as you are holding down that key. This hook ignores modifier keys (e.g. shift, control, option)
- `key_released` fires every time you release a key.
- `mouse_pressed` fires every time you click the mouse.
- `mouse_dragged` fires repeatedly as long as your holding down the mouse button and moving.
- `mouse_released` fires when you release the mouse.

## Dealing with Keyboard Events

In `06.rb`, we're reacting to the `key_pressed` event by resetting the constantly-incrementing `@x` variable back to 0. We're also sending some information to the terminal.

``` rb
def key_pressed
  warn "Key pressed: #{key.inspect}"
  @x = 0
end
```

`key.inspect` is all well and good for common letters, symbols, and carraige returns, but it doesn't work so well with arrow keys. In those cases we need to get the key's ASCII code. You can find a table of all ASCII key codes [here][ascii], but I usually just log the code and then hit buttons until I find the code I want.

[ascii]: http://help.adobe.com/en_US/AS2LCR/Flash_10.0/help.html?content=00000520.html

We normally just want the letter, number, or symbol though, so it's helpful to use a conditional.

``` rb
def key_pressed
  if key == CODED
    warn "Key pressed with code: #{keyCode}."
  else
    warn "Key pressed: #{key.inspect}"
  end
  @x = 0
end
```

In `07.rb` we change the y-coordinate of our circle with the up and down keys.

### Your Turn (Iteration 1)

`07a.rb` contains a stripped down version of the code we've been working with. Can you implement the following?

- The circle should respond to all four arrow keys and move in the appropriate direction when they're pressed.
- Define a key that returns the circle to the center.
- Increase and decrease the size of the circle with the `+` and `-` keys.

## Global Variables

- `mouse_x`: the position of the mouse along the x-axis.
- `mouse_y`: the position of the mouse along the y-axis.
- `pmouse_x`: the position of the mouse along the x-axis during the previous trip through the draw loop.
- `pmouse_y`: the position of the mouse along the y-axis during the previous trip through the draw loop.
- `key` always contains the value of the most recent key on the keyboard that was used (either pressed or released).
- `key_code` contains the ASCII value for the last key pressed (useful for arrow keys and others that don't have a letter value).

## Dealing with Mouse Events

Working with mouse events is a lot like working with keyboard events. You have some similar hooks and global variables. Let's see what that looks like in `08.rb`.

``` rb
def mouse_pressed
  warn "The mouse was pressed at #{mouse_x}, #{mouse_y}."
end

def mouse_dragged
  warn "Dragging mouse. (#{mouse_x}, #{mouse_y})."
end

def mouse_released
  warn "The mouse was released at #{mouse_x}, #{mouse_y}."
end
```

If you play around with `08.rb`, you'll notice that `mouse_dragged` fires a lot and is capped on both ends by a `mouse_pressed` and a `mouse_released`. The latter two are a great place to setup and takedown whatever you want to happen during the drag.

### Your Turn (Iteration 2)

Let's add a little more functionality to our little circle. Can you implement the following using `08a.rb` as a template?

- Get the circle to move the location of a mouse click on the canvas. (For example, if you click on 200, 180; the circle should move to 200, 180.)
- Get the circle to follow the mouse as you drag around.
- Get the circle to turn blue as you drag it around.

Extension:

- Update the arrow key functionality to allow the circle to glide in the direction.
- Have the circle change directions when it reaches the edge of the canvas.

### Rekindling Your Love for OOP

Writing everything out in a procedural fashion can get overwhelming pretty quickly. Luckily, this is Ruby and we can use classes to encapsulate data and behavior.

Here is a the foundation of a class that does some of the work of our lonely ellipse.

``` rb
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
    @x = x + 1
  end

end
```

As a result, our draw loop gets simplified a bit. (I instantiated `@circle` in the setup.)

``` rb
def draw
  background 0
  @circle.draw
  @circle.move_right
end
```

### Your Turn (Iteration 3)

This step is pretty straight-forward: refactor your existing functionality in a class, instantiate an instance of that class before your draw loop, and use that instance in your event hooks.

## Using Classes to Group Drawing Behavior

We can use classes to group a batches of drawing tasks in order to keep our code DRY. Let's take a look at the `draw` method on the `EmbarassedFace` class in `11.rb`.

``` rb
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
```

Drawing multiple faces is as simple as instantiating multiple objects.

``` rb
@first_face = EmbarassedFace.new 120, 120, 100, 100
@second_face = EmbarassedFace.new 360, 360, 100, 100
```

### Your Turn (Iteration 4)

One of my favorite sites was called [Processing Monsters][monsters]. The link is now dead, but I found a version of it in the Internet Archive, which I linked to above. (That said, OS X is not pleased with me trying to execute random Java code from my browser, so I wasn't able to actually play with any of my old friends. One of these days, I'm going to see if I can get my hands on the source and port them all to Processing.js.)

The premise is simple, a Processing Monster is a 2D, black and white character that responds to user input. We're going to create a Processing Monster.

Your monster sketch should:

- Present a canvas (of course)
- Loads a monster composed of multiple shapes
- Responds to user mouse input
- Responds to user keyboard input

Some things to try:

- Can you make your monster slowly follow the mouse, moving closer with each draw loop?
- Can you make your monster's eyes follow the mouse?
- Can you change your monster's properties based on keyboard input?
- Can you make your monsters hair or legs move based on the direction it's moving?

---

## Appendix

### An Aside: Alternate Syntax

For the purposes of this tutorial, I'm sticking with the syntax similar to what's in the samples. But, you may see a slightly different and more Ruby-like syntax. This works just as well and it's something that you may definitely find useful in certain cases.

``` rb
require 'ruby-processing'
class ProcessArtist < Processing::App

  def setup
    background(0, 0, 0)
  end

  def draw
    # Do Stuff
  end
end

ProcessArtist.new(:width => 800, :height => 800,
  :title => "ProcessArtist", :full_screen => false)
```

### Quick Note about `pmouse` and `mouse_pressed`

You can file this under "I probably don't need to know this right now, but if I encounter a weird bug somewhere down the road, this is probably why." So, you may be wondering why bother including `pmouse_x` and `pmouse_y` when you can just read the values of `mouse_x` and `mouse_y` when the `mouse_moved` or `mouse_dragged` event is called. Well, they work slightly different. The event hooks fire whenever the event happens. This could potentially be more than once during an event loop. `pmouse_x` and `pmouse_y` are *always* the values of the mouse location during the last run through the draw loop. So, it's possible that they're different.

[monsters]: http://web.archive.org/web/20120825175117/http://rmx.cz/monsters
