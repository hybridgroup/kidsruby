require_relative "../spec_helper"
require_relative "../../app/models/stdin_rejecter"

include KeyPressEventsTestHelper

describe StdinRejecter do
  it "calls the reject stdin method on its parent" do
    parent = mock('parent')
    parent.expects('rejectStdin')
    rejecter = StdinRejecter.new(parent, Qt::Key_Return)
    rejecter.keyPressEvent(return_key_press_event)
  end
end
