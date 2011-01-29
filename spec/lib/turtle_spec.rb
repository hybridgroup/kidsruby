require_relative "../spec_helper"
require_relative "../../lib/kidsruby/turtle"

describe Turtle do
  before do
    @interface = mock('interface')
    @interface.stubs(:valid?).returns(true)
    
    @reply = mock("reply")
    @reply.stubs(:valid?).returns(true)
    
    Turtle.any_instance.stubs(:get_interface).returns(@interface)
    Turtle.any_instance.stubs(:get_reply).returns(@reply)      
  end
  
  it "must initialize the remote Turtle" do     
    @interface.expects(:call).with('init_turtle').returns(true) #('init_turtle')
    @turtle = Turtle.new
  end
  
  describe "when interpreting colors" do
    before do
      @interface.stubs(:call)
      @turtle = Turtle.new
    end

    it "must know about green" do
      @turtle.green.must_equal("#008000")
    end

    it "must know about red" do
      @turtle.red.must_equal("#ff0000")
    end

    it "must know about blue" do
      @turtle.blue.must_equal("#0000ff")
    end

    it "must know about chocolate" do
      @turtle.chocolate.must_equal("#d2691e")
    end
  end
end