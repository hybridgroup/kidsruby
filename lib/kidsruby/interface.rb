class InterfaceHelper
  def connect!
    if !Qt::DBusConnection.sessionBus.connected?
    	$stderr.puts("Cannot connect to the D-BUS session bus.\n" \
    	                "To start it, run:\n" \
    	                "\teval `dbus-launch --auto-syntax`\n")
    	exit(1)
    end
  end
  
  def get_interface(location = "/")
    Qt::DBusInterface.new("com.kidsruby.app", location, "", Qt::DBusConnection.sessionBus)
  end

  def get_reply(message)
    Qt::DBusReply.new(message)
  end
end
