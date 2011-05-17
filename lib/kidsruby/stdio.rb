class KidsRubyStdIo
  attr_reader :interface

  def initialize(interface = InterfaceHelper.new.get_interface)
    @interface = interface
  end

  def puts(data)
    write(data.to_s + "\n")
  end
end

class StdOut < KidsRubyStdIo
  def write(data)
    t = data.gsub(/\n/,"<br/>")
    interface.call("append", t)
  end
end

class StdErr < KidsRubyStdIo
  def write(data)
    t = data.gsub(/\n/,"<br/>")
    interface.call("appendError", t)
  end
end

$stdout.sync = true
$stdout = StdOut.new

$stderr.sync = true
$stderr = StdErr.new
