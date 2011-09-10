require_relative "../spec_helper"
require_relative "../../lib/kidsruby/interface"
require_relative "../../lib/kidsruby/dialogs"

describe 'dialogs' do
  before do
    @interface = mock('interface')
    @interface.stubs(:valid?).returns(true)

    @reply = mock("reply")
    @reply.stubs(:valid?).returns(true)

    InterfaceHelper.any_instance.stubs('get_interface').returns(@interface)
  end

  it "must be able to show alert" do
    @answer = "hello"
    @reply.stubs(:value).returns(@answer)
    @interface.expects(:call).with('alert', @answer).returns(@reply)
    alert(@answer)
  end

  it "must be able to show ask" do
    @answer = "you there?"
    @reply.stubs(:value).returns(@answer)
    @interface.expects(:call).with('ask', @answer).returns(@reply)
    ask(@answer)
  end

  describe "gets" do
    it "must be able to get input" do
      # HACK TO MAKE THIS SPEC WORK
      # WITH `rake spec`
      ARGV.clear
      # END HACK
     
      @answer = "hola"
      @reply.stubs(:value).returns(@answer)
      stdin = mock("standard input")
      stdin.expects(:gets).returns(@answer)
      $stdin = stdin
      @interface.expects('call').with('gets').returns(@reply)
      gets.must_equal(@answer)
    end
  end
end
