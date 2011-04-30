# this is designed to trigger dialogs for kidsruby for ask and alert compatible with hackety hack
def init_interface
  @interface_helper = InterfaceHelper.new
  @interface_helper.connect!
  @iface = @interface_helper.get_interface
end

def ask(text)
  init_interface

  if @iface.valid?
    message = @iface.call("ask", text)
    reply = @interface_helper.get_reply(message)
    if reply.valid?
      return reply.value
    end

    $stderr.puts("Ask call failed: %s\n" % reply.error_message)
  end  
  return nil
end

def alert(text)
  init_interface

  if @iface.valid?
    message = @iface.call("alert", text)
    reply = @interface_helper.get_reply(message)
    if reply.valid?
      return true
    end

    $stderr.puts("Alert call failed: %s\n" % reply.error_message)
  end
  return nil
end

alias :__gets__ :gets
def gets
   init_interface

  if @iface.valid?
    message = @iface.call("gets")
    reply = @interface_helper.get_reply(message)
    if reply.valid?
      return __gets__
    end

    $stderr.puts("gets call failed: %s\n" % reply.error_message)
  end
end
