class KidsRubyStdIo
  def initialize
    @iface = InterfaceHelper.new.get_interface
  end
end

class StdOut < KidsRubyStdIo
  def write(data)
    t = data.gsub(/\n/,"<br/>")
    @iface.call("append", t)
  end
  alias_method :puts, :write
end

class StdErr < KidsRubyStdIo
  def write(data)
    t = data.gsub(/\n/,"<br/>")
    @iface.call("appendError", t)
  end
  alias_method :puts, :write
end

$stdout.sync = true
$stdout = StdOut.new

$stderr.sync = true
$stderr = StdErr.new