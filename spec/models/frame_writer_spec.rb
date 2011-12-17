require_relative "../spec_helper"
require_relative "../../app/models/frame_writer"

include KeyPressEventsTestHelper

describe FrameWriter do
  before do
    @frame = mock('frame')
  end

  describe "sending return key press event" do
    it "delegates to the frame" do
      @frame.expects('evaluateJavaScript').with("cutStdInToStdOut();")
      @frame.expects('evaluateJavaScript').with("updateStdOut('<br/>');")
      @frame.expects('evaluateJavaScript').with("removeCursor();")
      FrameWriter.new(@frame).keyPressEvent(return_key_press_event)
    end
  end

  describe "sending backspace key press event" do
    it "delegates to the frame" do
      @frame.expects(:evaluateJavaScript).with("deleteLastStdIn();")
      FrameWriter.new(@frame).keyPressEvent(backspace_key_press_event)
    end
  end

  describe "sending z key press event" do
    it "delegates to the frame" do
      @frame.expects(:evaluateJavaScript).with("updateStdIn('z');")
      FrameWriter.new(@frame).keyPressEvent(z_key_press_event)
    end
  end
end
