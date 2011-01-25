require "./#{File.dirname(__FILE__)}/../spec_helper.rb"
require "./#{File.dirname(__FILE__)}/../../app/models/turtle.rb"

describe Turtle do
  before do
    @turtle = Turtle.new
  end
  
  it "must instanciate a Turtle" do
    @turtle.wont_be_nil
  end    
end