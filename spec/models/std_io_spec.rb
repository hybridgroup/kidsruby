require_relative "../spec_helper"
require_relative "../../lib/kidsruby"

describe KidsRubyStdIo do
  it "should default the interface to a new one from InterfaceHelper" do
    # We can not test that interface == InterfaceHelper.new.get_interface
    #   since it will be a different instance of get_interface.
    # Therefore, we stub get_interface
    InterfaceHelper.any_instance.stubs(:get_interface => "TEST INTERFACE")
    KidsRubyStdIo.new().interface.must_equal "TEST INTERFACE"
  end

  describe '.simple_textilize' do
    it "should convert newlines to html line break" do
      input    = "a\n2\nc\n"
      expected = "a<br/>2<br/>c<br/>"
      KidsRubyStdIo.new.simple_textilize(input).must_equal expected
    end
  end
end

describe StdOut do
  describe ".puts" do
    it "should forward the coerced, new-lined data to .write" do
      subject = StdOut.new
      subject.expects(:write).with("123\n")
      subject.puts(123)
    end
  end

  describe ".write" do
    it "should convert the text to html and append it to the interface" do
      test_interface = mock()
      test_interface.expects(:call).with("append", "123<br/>")

      StdOut.new(test_interface).write("123\n")
    end
  end
end

describe StdErr do
  describe ".puts" do
    it "should forward the coerced, newlined data to .write" do
      subject = StdErr.new
      subject.expects(:write).with("234\n")
      subject.puts(234)
    end
  end

  describe ".write" do
    it "should convert the text to html and append it (as error) to the interface" do
      test_interface = mock()
      test_interface.expects(:call).with("appendError", "234<br/>")

      StdErr.new(test_interface).write("234\n")
    end
  end
end
