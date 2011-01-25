# this is designed to trigger dialogs for kidsruby for ask and alert compatible with hackety hack
require 'Qt'

if !Qt::DBusConnection.sessionBus.connected?
	$stderr.puts("Cannot connect to the D-BUS session bus.\n" \
	                "To start it, run:\n" \
	                "\teval `dbus-launch --auto-syntax`\n")
	exit(1)
end
	
@iface = Qt::DBusInterface.new("com.kidsruby.app", "/", "", Qt::DBusConnection.sessionBus)

def ask(text)
  if @iface.valid?
    message = @iface.call("ask", text)
    reply = Qt::DBusReply.new(message)
    if reply.valid?
      return reply.value
    end

    $stderr.puts("Ask call failed: %s\n" % reply.error.message)
  end  
  return nil
end

def alert(text)
  if @iface.valid?
    message = @iface.call("alert", text)
    reply = Qt::DBusReply.new(message)
    if reply.valid?
      return true
    end

    $stderr.puts("Alert call failed: %s\n" % reply.error.message)
  end
  return nil
end