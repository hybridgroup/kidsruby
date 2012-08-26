class KidsRubyStdIo
  attr_reader :interface

  def initialize(interface = InterfaceHelper.new.get_interface)
    @interface = interface
  end

  def puts(data)
    write(data.to_s + "\n")
  end

  def print(*objs)
    objs.each {|o| write(o.to_s)}
  end

  # (very) Simple textilize-like converter
  # Converts newlines to html line breaks
  def simple_textilize(text)
    # TODO: should we use an actual textilize/markdown filter?
    #   Or simple_format from actionpack/lib/action_view/helpers/text_helper.rb
    text.gsub(/\n/,"<br/>")
  end

  def flush; end
end

class StdOut < KidsRubyStdIo
  def write(data, as_error = false)
    interface.call("append", simple_textilize(data))
  end
end

class StdErr < KidsRubyStdIo
  def write(data)
    interface.call("appendError", simple_textilize(data))
  end
end

class StdIn
  def gets
    super
  end
end

$stdout.sync = true
$stdout = StdOut.new

$stderr.sync = true
$stderr = StdErr.new

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
