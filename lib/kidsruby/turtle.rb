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
  
  class << self
    def start(&script)
      self.new.instance_eval(&script)
    end
  end
  
  # ex: blue
  def background(color)
    if @iface.valid?
      message = @iface.call("background", color)
      reply = Qt::DBusReply.new(message)
      if reply.valid?
        return true
      end

      $stderr.puts("Background call failed: %s\n" % reply.error.message)
    end  
    return nil
  end
  
  # ex: 2
  def pensize(size)
    if @iface.valid?
      message = @iface.call("pensize", color)
      reply = Qt::DBusReply.new(message)
      if reply.valid?
        return true
      end

      $stderr.puts("Pensize call failed: %s\n" % reply.error.message)
    end  
    return nil
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
    if @iface.valid?
      message = @iface.call("goto", x, y)
      reply = Qt::DBusReply.new(message)
      if reply.valid?
        return true
      end

      $stderr.puts("goto call failed: %s\n" % reply.error.message)
    end  
    return nil    
  end
  
  def setheading(heading)
    if @iface.valid?
      message = @iface.call("setheading", heading)
      reply = Qt::DBusReply.new(message)
      if reply.valid?
        return true
      end

      $stderr.puts("setheading call failed: %s\n" % reply.error.message)
    end  
    return nil    
  end

  def forward(distance)
    if @iface.valid?
      message = @iface.call("forward", distance)
      reply = Qt::DBusReply.new(message)
      if reply.valid?
        return true
      end

      $stderr.puts("forward call failed: %s\n" % reply.error.message)
    end  
    return nil
  end
  
  def turnleft(degrees)
    if @iface.valid?
      message = @iface.call("turnleft", degrees)
      reply = Qt::DBusReply.new(message)
      if reply.valid?
        return true
      end

      $stderr.puts("turnleft call failed: %s\n" % reply.error.message)
    end  
    return nil    
  end

  def turnright(degrees)
    if @iface.valid?
      message = @iface.call("turnright", degrees)
      reply = Qt::DBusReply.new(message)
      if reply.valid?
        return true
      end

      $stderr.puts("Pencolor call failed: %s\n" % reply.error.message)
    end  
    return nil        
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