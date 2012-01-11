require_relative "../spec_helper"
require_relative "../../lib/kidsruby/interface"
require_relative "../../lib/kidsruby/turtle"

describe Turtle do
  before do
    @iface = mock('interface')
    @iface.stubs(:valid?).returns(true)
    
    @reply = mock("reply")
    @reply.stubs(:valid?).returns(true)
    
    InterfaceHelper.any_instance.stubs('get_interface').returns(@iface)
  end
  
  it "must initialize the remote Turtle" do     
    @value = true
    @reply.stubs(:value).returns(@value)

    @iface.expects(:call).with('init_turtle').returns(@reply)
    @turtle = Turtle.new
  end
  
  describe "when working with the class methods" do
    it "must be able to draw" do
      @val = "#fff"
      @reply.stubs(:value).returns(@val)

      @iface.expects(:call).with('init_turtle').returns(@reply)
      @iface.expects(:call).with("background", @value).returns(@reply)
      @iface.expects(:call).with("command_turtle", 'draw();').returns(@reply)
      Turtle.draw do
        background(@val)
      end
    end
  end

  describe "when properly initialized" do
    before do
      @iface.stubs(:call).with('init_turtle').returns(@reply)
      @turtle = Turtle.new
    end
    
    it "must have a background color" do
      @value = "#fff"
      @reply.stubs(:value).returns(@value)
      @iface.expects(:call).with("background", @value).returns(@reply)
      @turtle.background(@value)
    end

    it "must have a pensize" do
      @value = 3
      @reply.stubs(:value).returns(@value)
      @turtle.expects(:add_command)
      @turtle.pensize(@value)
    end

    it "must have a pencolor" do
      @value = "#fff"
      @reply.stubs(:value).returns(@value)
      @turtle.expects(:add_command)
      @turtle.pencolor(@value)
    end

    it "must be able to goto a location" do
      x, y = 3, 4
      @value = 5
      @reply.stubs(:value).returns(@value)
      @turtle.stubs("height").returns(@value)
      @turtle.expects(:add_command)
      @turtle.goto(x, y)
    end

    it "must be able to setheading" do
      @value = 90
      @reply.stubs(:value).returns(@value)
      @turtle.expects(:add_command)
      @turtle.setheading(@value)
    end

    it "must be able to move forward" do
      @value = 3
      @reply.stubs(:value).returns(@value)
      @turtle.expects(:add_command)
      @turtle.forward(@value)
    end

    it "must be able to move backward" do
      @value = 3
      @reply.stubs(:value).returns(@value)
      @turtle.expects(:add_command)
      @turtle.backward(@value)
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
      @value = 3
      @reply.stubs(:value).returns(@value)
      @iface.expects(:call).with("width").returns(@reply)
      @turtle.width.must_equal(@value)
    end

    it "must have a height" do
      @value = 4
      @reply.stubs(:value).returns(@value)
      @iface.expects(:call).with("height").returns(@reply)
      @turtle.height.must_equal(@value)
    end

  end
  
  describe "when interpreting colors" do
    before do
      @iface.stubs(:call).returns(@reply)
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

    it "must know about rgb colors" do
      @turtle.rgb(255, 0, 0).must_equal("#ff0000")
    end
  end
end
