require_relative "../spec_helper"
require_relative "../../app/models/turtle.rb"

describe Turtle do
  before do
    @turtle = Turtle.new
  end
  
  it "must instanciate a Turtle" do
    @turtle.wont_be_nil
  end
end