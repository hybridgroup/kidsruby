# Hackety Hack compatible turtle class
require 'Qt'

class Turtle
  def initialize
    if !Qt::DBusConnection.sessionBus.connected?
    	$stderr.puts("Cannot connect to the D-BUS session bus.\n" \
    	                "To start it, run:\n" \
    	                "\teval `dbus-launch --auto-syntax`\n")
    	exit(1)
    end

    @iface = Qt::DBusInterface.new("com.kidsruby.app", "/Turtle", "", Qt::DBusConnection.sessionBus)
  end
  
  def self.start
  end
  
  # ex: blue
  def background(color)
  end
  
  # ex: 2
  def pensize(size)
  end
  
  # ex: yellow
  def pencolor(color)
    if @iface.valid?
      message = @iface.call("pencolor", color)
      reply = Qt::DBusReply.new(message)
      if reply.valid?
        return true
      end

      $stderr.puts("Pencolor call failed: %s\n" % reply.error.message)
    end  
    return nil
  end
  
  def goto(x, y)
  end
  
  def setheading(heading)
  end

  def forward(distance)
    if @iface.valid?
      message = @iface.call("forward", distance)
      reply = Qt::DBusReply.new(message)
      if reply.valid?
        return true
      end

      $stderr.puts("Draw call failed: %s\n" % reply.error.message)
    end  
    return nil
  end
  
  def turnleft(degrees)
  end

  def turnright(degrees)
  end
  
  def draw
    if @iface.valid?
      message = @iface.call("draw")
      reply = Qt::DBusReply.new(message)
      if reply.valid?
        return true
      end

      $stderr.puts("Draw call failed: %s\n" % reply.error.message)
    end  
    return nil
  end
end