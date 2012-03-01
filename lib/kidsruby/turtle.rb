# Hackety Hack compatible turtle class
class Turtle
  attr_reader :commands

  def initialize
    @commands = []
    @interface = InterfaceHelper.new.get_interface("/turtle")
    init_turtle
  end

  class << self
    def start(&script)
      t = self.new
      t.instance_eval(&script)
      t.draw
    end

    alias_method :draw, :start
  end

  def init_turtle
    if @interface.valid?
      reply = @interface.call("init_turtle")
      $stderr.puts("init_turtle call failed: %s\n" % reply.error_message) unless reply.valid?
    end
  end

  def send_commands
    cmds = @commands.join(".")
    if @interface.valid?
      reply = @interface.call("command_turtle", cmds)
      if reply.valid?
        @commands = []
        return true
      end

      $stderr.puts("command_turtle call failed: %s\n" % reply.error_message)
    end  
    return nil
  end

  def add_command(command)
    @commands << command
  end

  # ex: blue
  def background(color)
    if @interface.valid?
      reply = @interface.call("background", color)
      if reply.valid?
        @commands = []
        return true
      end

      $stderr.puts("background call failed: %s\n" % reply.error_message)
    end
    return nil
  end

  # ex: 2
  def pensize(size)
    add_command "pensize(#{size})"
  end

  # ex: yellow
  def pencolor(color)
    add_command "penstyle('#{color}')"
  end

  def goto(x, y)
    add_command "jump(#{x}, #{y})"
  end

  def setheading(heading)
    add_command "angle(#{heading})"
  end

  def forward(distance)
    add_command "go(#{distance})"
  end

  def backward(distance)
    add_command "back(#{distance})"
  end

  def turnleft(degrees)
    add_command "turn(#{-degrees.abs})"
  end

  def turnright(degrees)
    add_command "turn(#{degrees.abs})"
  end

  def draw
    add_command "draw();"
    send_commands
  end

  def width
    if @interface.valid?
      reply = @interface.call("width")
      if reply.valid?
        return reply.value.to_i
      end

      $stderr.puts("Width call failed: %s\n" % reply.error_message)
    end
    return nil
  end

  def height
    if @interface.valid?
      reply = @interface.call("height")
      if reply.valid?
        return reply.value.to_i
      end

      $stderr.puts("Height call failed: %s\n" % reply.error_message)
    end
    return nil
  end

  # colors
  def method_missing(method, *args, &block)
    return COLORS[method.to_s]
  end

  def self.rgb(r, g, b)
    hex_string = "#"
    hex_string << "%02x" % r.to_i
    hex_string << "%02x" % g.to_i
    hex_string << "%02x" % b.to_i
    hex_string
  end

  def rgb(r, g, b)
    self.class.rgb(r, g, b)
  end

  COLORS = {
    'aliceblue' => rgb(240, 248, 255),
    'antiquewhite' => rgb(250, 235, 215),
    'aqua' => rgb(0, 255, 255),
    'aquamarine' => rgb(127, 255, 212),
    'azure' => rgb(240, 255, 255),
    'beige' => rgb(245, 245, 220),
    'bisque' => rgb(255, 228, 196),
    'black' => rgb(0, 0, 0),
    'blanchedalmond' => rgb( 255, 235, 205),
    'blue' => rgb(0, 0, 255),
    'blueviolet' => rgb(138, 43, 226),
    'brown' => rgb(165, 42, 42),
    'burlywood' => rgb(222, 184, 135),
    'cadetblue' => rgb(95, 158, 160),
    'chartreuse' => rgb(127, 255, 0),
    'chocolate' => rgb(210, 105, 30),
    'coral' => rgb(255, 127, 80),
    'cornflowerblue' => rgb(100, 149, 237),
    'cornsilk' => rgb(255, 248, 220),
    'crimson' => rgb(220, 20, 60),
    'cyan' => rgb(0, 255, 255),
    'darkblue' => rgb(0, 0, 139),
    'darkcyan' => rgb(0, 139, 139),
    'darkgoldenrod' => rgb(184, 134, 11),
    'darkgray' => rgb(169, 169, 169),
    'darkgreen' => rgb(0, 100, 0),
    'darkkhaki' => rgb(189, 183, 107),
    'darkmagenta' => rgb(139, 0, 139),
    'darkolivegreen' => rgb(85, 107, 47),
    'darkorange' => rgb(255, 140, 0),
    'darkorchid' => rgb(153, 50, 204),
    'darkred' => rgb(139, 0, 0),
    'darksalmon' => rgb(233, 150, 122),
    'darkseagreen' => rgb(143, 188, 143),
    'darkslateblue' => rgb(72, 61, 139),
    'darkslategray' => rgb(47, 79, 79),
    'darkturquoise' => rgb(0, 206, 209),
    'darkviolet' => rgb(148, 0, 211),
    'deeppink' => rgb(255, 20, 147),
    'deepskyblue' => rgb(0, 191, 255),
    'dimgray' => rgb(105, 105, 105),
    'dodgerblue' => rgb(30, 144, 255),
    'firebrick' => rgb(178, 34, 34),
    'floralwhite' => rgb(255, 250, 240),
    'forestgreen' => rgb(34, 139, 34),
    'fuchsia' => rgb(255, 0, 255),
    'gainsboro' => rgb(220, 220, 220),
    'ghostwhite' => rgb(248, 248, 255),
    'gold' => rgb(255, 215, 0),
    'goldenrod' => rgb(218, 165, 32),
    'gray' => rgb(128, 128, 128),
    'green' => rgb(0, 128, 0),
    'greenyellow' => rgb(173, 255, 47),
    'honeydew' => rgb(240, 255, 240),
    'hotpink' => rgb(255, 105, 180),
    'indianred' => rgb(205, 92, 92),
    'indigo' => rgb(75, 0, 130),
    'ivory' => rgb(255, 255, 240),
    'khaki' => rgb(240, 230, 140),
    'lavender' => rgb(230, 230, 250),
    'lavenderblush' => rgb(255, 240, 245),
    'lawngreen' => rgb(124, 252, 0),
    'lemonchiffon' => rgb(255, 250, 205),
    'lightblue' => rgb(173, 216, 230),
    'lightcoral' => rgb(240, 128, 128),
    'lightcyan' => rgb(224, 255, 255),
    'lightgoldenrodyellow' => rgb(250, 250, 210),
    'lightgreen' => rgb(144, 238, 144),
    'lightgrey' => rgb(211, 211, 211),
    'lightpink' => rgb(255, 182, 193),
    'lightsalmon' => rgb(255, 160, 122),
    'lightseagreen' => rgb(32, 178, 170),
    'lightskyblue' => rgb(135, 206, 250),
    'lightslategray' => rgb(119, 136, 153),
    'lightsteelblue' => rgb(176, 196, 222),
    'lightyellow' => rgb(255, 255, 224),
    'lime' => rgb(0, 255, 0),
    'limegreen' => rgb(50, 205, 50),
    'linen' => rgb(250, 240, 230),
    'magenta' => rgb(255, 0, 255),
    'maroon' => rgb(128, 0, 0),
    'mediumaquamarine' => rgb(102, 205, 170),
    'mediumblue' => rgb(0, 0, 205),
    'mediumorchid' => rgb(186, 85, 211),
    'mediumpurple' => rgb(147, 112, 219),
    'mediumseagreen' => rgb(60, 179, 113),
    'mediumslateblue' => rgb(123, 104, 238),
    'mediumspringgreen' => rgb(0, 250, 154),
    'mediumturquoise' => rgb(72, 209, 204),
    'mediumvioletred' => rgb(199, 21, 133),
    'midnightblue' => rgb(25, 25, 112),
    'mintcream' => rgb(245, 255, 250),
    'mistyrose' => rgb(255, 228, 225),
    'moccasin' => rgb(255, 228, 181),
    'navajowhite' => rgb(255, 222, 173),
    'navy' => rgb(0, 0, 128),
    'oldlace' => rgb(253, 245, 230),
    'olive' => rgb(128, 128, 0),
    'olivedrab' => rgb(107, 142, 35),
    'orange' => rgb(255, 165, 0),
    'orangered' => rgb(255, 69, 0),
    'orchid' => rgb(218, 112, 214),
    'palegoldenrod' => rgb(238, 232, 170),
    'palegreen' => rgb(152, 251, 152),
    'paleturquoise' => rgb(175, 238, 238),
    'palevioletred' => rgb(219, 112, 147),
    'papayawhip' => rgb(255, 239, 213),
    'peachpuff' => rgb(255, 218, 185),
    'peru' => rgb(205, 133, 63),
    'pink' => rgb(255, 192, 203),
    'plum' => rgb(221, 160, 221),
    'powderblue' => rgb(176, 224, 230),
    'purple' => rgb(128, 0, 128),
    'red' => rgb(255, 0, 0),
    'rosybrown' => rgb(188, 143, 143),
    'royalblue' => rgb(65, 105, 225),
    'saddlebrown' => rgb(139, 69, 19),
    'salmon' => rgb(250, 128, 114),
    'sandybrown' => rgb(244, 164, 96),
    'seagreen' => rgb(46, 139, 87),
    'seashell' => rgb(255, 245, 238),
    'sienna' => rgb(160, 82, 45),
    'silver' => rgb(192, 192, 192),
    'skyblue' => rgb(135, 206, 235),
    'slateblue' => rgb(106, 90, 205),
    'slategray' => rgb(112, 128, 144),
    'snow' => rgb(255, 250, 250),
    'springgreen' => rgb(0, 255, 127),
    'steelblue' => rgb(70, 130, 180),
    'tan' => rgb(210, 180, 140),
    'teal' => rgb(0, 128, 128),
    'thistle' => rgb(216, 191, 216),
    'tomato' => rgb(255, 99, 71),
    'turquoise' => rgb(64, 224, 208),
    'violet' => rgb(238, 130, 238),
    'wheat' => rgb(245, 222, 179),
    'white' => rgb(255, 255, 255),
    'whitesmoke' => rgb(245, 245, 245),
    'yellow' => rgb(255, 255, 0),
    'yellowgreen' => rgb(154, 205, 50)
  }
end
