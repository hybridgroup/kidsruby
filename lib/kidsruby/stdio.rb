class KidsRubyStdIo
  def initialize
    @iface = InterfaceHelper.new.get_interface
  end

  def puts(data)
    write(data.to_s + "\n")
  end
end

class StdOut < KidsRubyStdIo
  def write(data)
    t = data.gsub(/\n/,"<br/>")
    @iface.call("append", t)
  end
end

class StdErr < KidsRubyStdIo
  def write(data)
    t = data.gsub(/\n/,"<br/>")
    @iface.call("appendError", t)
  end
end

$stdout.sync = true
$stdout = StdOut.new

$stderr.sync = true
$stderr = StdErr.new
