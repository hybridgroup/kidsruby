require_relative "../spec_helper"
require_relative "../../lib/kidsruby/interface"
require_relative "../../lib/kidsruby/turtle"

describe Turtle do
  before do
    @interface = mock('interface')
    @interface.stubs(:valid?).returns(true)
    
    @value = 100
    @reply = mock("reply")
    @reply.stubs(:valid?).returns(true)
    @reply.stubs(:value).returns(@value)
    
    InterfaceHelper.any_instance.stubs('get_interface').returns(@interface)
    InterfaceHelper.any_instance.stubs('get_reply').returns(@reply)
  end
  
  it "must initialize the remote Turtle" do     
    @interface.expects(:call).with('init_turtle').returns(true)
    @turtle = Turtle.new
  end
  
  describe "when working with the class methods" do
    it "must be able to draw" do
      color = "#fff"
      @interface.stubs(:call).with('init_turtle')
      @interface.expects(:call).with("background", color)
      @interface.expects(:call).with("command_turtle", 'draw();')
      Turtle.draw do
        background(color)
      end
    end
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
      @turtle.expects(:add_command)
      @turtle.pensize(size)
    end

    it "must have a pencolor" do
      color = "#fff"
      @turtle.expects(:add_command)
      @turtle.pencolor(color)
    end

    it "must be able to goto a location" do
      height = 5
      x, y = 3, 4
      @turtle.stubs("height").returns(height)
      @turtle.expects(:add_command)
      @turtle.goto(x, y)
    end

    it "must be able to setheading" do
      heading = 90
      @turtle.expects(:add_command)
      @turtle.setheading(heading)
    end

    it "must be able to move forward" do
      distance = 3
      @turtle.expects(:add_command)
      @turtle.forward(distance)
    end

    it "must be able to move backward" do
      distance = 3
      @turtle.expects(:add_command)
      @turtle.backward(distance)
    end

    it "must be able to turnleft" do
      degrees = 45
      @turtle.expects(:add_command)
      @turtle.turnleft(degrees)
    end

    it "must be able to turnright" do
      degrees = 45
      @turtle.expects(:add_command)
      @turtle.turnright(degrees)
    end

    it "must be able to draw" do
      @turtle.expects(:add_command)
      @turtle.expects(:send_commands)
      @turtle.draw
    end

    it "must have a width" do
      @interface.expects(:call).with("width")
      @turtle.width.must_equal(@value)
    end

    it "must have a height" do
      @interface.expects(:call).with("height")
      @turtle.height.must_equal(@value)
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