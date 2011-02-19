require_relative '../spec_helper'
require_relative '../../app/models/line_printer'

describe LinePrinter do
  before do
    @frame = stub("frame", :evaluateJavaScript => nil)
    @device = stub("iodevice") 
  end

  def init_line_printer
    @lp = LinePrinter.new(@frame, @device)
  end

  it "initializes a line" do
    init_line_printer

    @frame.expects("evaluateJavaScript").with("initStdInLine()")
    @lp.line.must_equal ""
  end

  it "builds line" do
    init_line_printer

    @lp << "my name is jonas"
    @lp.line.must_equal "my name is jonas"
  end

  it "prints line" do
    @frame.expects("evaluateJavaScript").with("cutStdInToStdOut()")
    @device.expects("write").with("answer\n")
    init_line_printer

    @lp << "answer"
    @lp.print.must_equal "answer\n"
  end

  it "deletes last character" do
    @frame.expects("evaluateJavaScript").with("replaceStdIn('string', 'strin')")
    init_line_printer

    @lp << "string"
    @lp.delete_last.must_equal "strin"
    @lp.line.must_equal "strin"
  end

  it "clears the internal line" do
    init_line_printer

    @lp << "string"
    @lp.clear
    @lp.line.must_equal ""
  end
end
