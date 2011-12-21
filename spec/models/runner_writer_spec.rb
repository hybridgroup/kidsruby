require_relative "../spec_helper"
require_relative "../../app/models/runner_writer"

include KeyPressEventsTestHelper

describe RunnerWriter do

  before do
    @runner = mock("runner")
    @runner_writer = RunnerWriter.new(@runner)
  end

  describe "sending return key press" do
    it "must write the line to the runner" do
      @runner.expects(:write).with("\n") 
      @runner_writer.keyPressEvent(return_key_press_event)
      @runner_writer.line.must_equal ""
    end
  end

  describe "sending only modifier key press event" do
    it "must not send characters into the line when only shift is pressed" do
      @runner_writer.keyPressEvent(shift_key_press_event)
      @runner_writer.line.must_equal ""
    end
  end

  describe "sending any other key press event" do
    it "must buffer regular characters into the line" do
      @runner_writer.keyPressEvent(z_key_press_event)
      @runner_writer.line.must_equal "z"
    end
  end

  describe "sending backspace key press" do
    it "must delete the last character from the line" do
      @runner_writer.keyPressEvent(z_key_press_event)
      @runner_writer.keyPressEvent(z_key_press_event)
      @runner_writer.keyPressEvent(backspace_key_press_event)
      @runner_writer.line.must_equal "z"
    end
  end
end
