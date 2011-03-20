class StdOut
  def initialize
    @iface = InterfaceHelper.new.get_interface
  end
  
  def write(data)
    t = data.gsub(/\n/,"<br/>")
    @iface.call("append", t)
  end
end

class StdErr
  def initialize
    @iface = InterfaceHelper.new.get_interface
  end
  
  def write(data)
    t = data.gsub(/\n/,"<br/>")
    @iface.call("appendError", t)
  end
end

$stdout.sync = true
$stdout = StdOut.new

$stderr.sync = true
$stderr = StdErr.new