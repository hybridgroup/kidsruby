# this is designed to trigger dialogs for kidsruby for ask and alert compatible with hackety hack
def init_interface
  @iface = InterfaceHelper.new.get_interface
end

def is_numeric?(value)
  Float(value) != nil rescue false
end

def convert_to_number(value)
  value = Float(value)
  value.to_i == value ? value.to_i : value
end
  
def ask(text)
  init_interface

  if @iface.valid?
    reply = @iface.call("ask", text)
    if reply.valid?
      if is_numeric?(reply.value)
        return convert_to_number(reply.value)
      else
        return reply.value
      end
    end

    $stderr.puts("Ask call failed: %s\n" % reply.error_message)
  end  
  return nil
end

def alert(text)
  init_interface

  if @iface.valid?
    reply = @iface.call("alert", text)
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
    reply = @iface.call("gets")
    if reply.valid?
      return __gets__
    end

    $stderr.puts("gets call failed: %s\n" % reply.error_message)
  end
end
