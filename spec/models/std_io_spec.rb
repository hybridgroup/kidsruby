require_relative "../spec_helper"
require_relative "../../lib/kidsruby"

describe StdOut do
  describe ".puts" do
    it "should delegate the coerced, new-lined data to .write" do
      stdout_ut = StdOut.new
      stdout_ut.expects(:write).with("123\n")
      stdout_ut.puts(123)
    end
  end
end

