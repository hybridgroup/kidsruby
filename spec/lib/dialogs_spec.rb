require_relative "../spec_helper"
require_relative "../../lib/kidsruby/interface"
require_relative "../../lib/kidsruby/dialogs"

describe 'dialogs' do
  before do
    @interface = mock('interface')
    @interface.stubs(:valid?).returns(true)
    
    @answer = "yes"
    @reply = mock("reply")
    @reply.stubs(:valid?).returns(true)
    @reply.stubs(:value).returns(@answer)
    
    InterfaceHelper.any_instance.stubs('get_interface').returns(@interface)
    InterfaceHelper.any_instance.stubs('get_reply').returns(@reply)      
  end
  
  it "must be able to show alert" do
    text = "hello"
    @interface.expects(:call).with('alert', text).returns(true)
    alert(text)
  end
  
  it "must be able to show ask" do
    text = "you there?"
    @interface.expects(:call).with('ask', text).returns(@answer)
    ask(text)
  end
  
end