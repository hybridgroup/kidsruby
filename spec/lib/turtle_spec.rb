require_relative "../spec_helper"
require_relative "../../lib/kidsruby/turtle"

describe Turtle do
  before do
    @turtle = Turtle.new
  end
  
  describe "must be able to interpret colors" do
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