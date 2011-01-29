require_relative "../spec_helper"
require_relative "../../lib/kidsruby/interface"
require_relative "../../lib/kidsruby/turtle"

describe Turtle do
  before do
    @interface = mock('interface')
    @interface.stubs(:valid?).returns(true)
    
    @reply = mock("reply")
    @reply.stubs(:valid?).returns(true)
    
    InterfaceHelper.any_instance.stubs('get_interface').returns(@interface)
    InterfaceHelper.any_instance.stubs('get_reply').returns(@reply)
  end
  
  it "must initialize the remote Turtle" do     
    @interface.expects(:call).with('init_turtle').returns(true)
    @turtle = Turtle.new
  end
  
  describe "when properly initialized" do
    before do
      @interface.stubs(:call).with('init_turtle')
      @turtle = Turtle.new
    end
    
    it "must have a background color" do
      color = "#fff"
      @interface.expects(:call).with("background", color)
      @turtle.background(color)
    end

    it "must have a pensize" do
      size = 3
      @interface.expects(:call).with("pensize", size)
      @turtle.pensize(size)
    end

    it "must have a pencolor" do
      color = "#fff"
      @interface.expects(:call).with("pencolor", color)
      @turtle.pencolor(color)
    end

    it "must be able to goto a location" do
      x, y = 3, 4
      @interface.expects(:call).with("goto", x, y)
      @turtle.goto(x, y)
    end

    it "must be able to setheading" do
      heading = 90
      @interface.expects(:call).with("setheading", heading + 180)
      @turtle.setheading(heading)
    end

    it "must be able to move forward" do
      distance = 3
      @interface.expects(:call).with("forward", distance)
      @turtle.forward(distance)
    end

    it "must be able to move backward" do
      distance = 3
      @interface.expects(:call).with("backward", distance)
      @turtle.backward(distance)
    end

    it "must be able to turnleft" do
      degrees = 45
      @interface.expects(:call).with("turnleft", degrees)
      @turtle.turnleft(degrees)
    end

    it "must be able to turnright" do
      degrees = 45
      @interface.expects(:call).with("turnright", degrees)
      @turtle.turnright(degrees)
    end

    it "must be able to draw" do
      @interface.expects(:call).with("draw")
      @turtle.draw
    end

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