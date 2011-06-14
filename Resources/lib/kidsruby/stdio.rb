class KidsRubyStdIo
  attr_reader :interface

  def initialize(interface = InterfaceHelper.new.get_interface)
    @interface = interface
  end

  def puts(data)
    write(data.to_s + "\n")
  end

  # (very) Simple textilize-like converter
  # Converts newlines to html line breaks
  def simple_textilize(text)
    # TODO: should we use an actual textilize/markdown filter?
    #   Or simple_format from actionpack/lib/action_view/helpers/text_helper.rb
    text.gsub(/\n/,"<br/>")
  end
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

$stdout.sync = true
$stdout = StdOut.new

$stderr.sync = true
$stderr = StdErr.new
