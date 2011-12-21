require 'rubygems'
require 'minitest/autorun'
#require 'minitest/pride'
require 'mocha'
require 'Qt4'

module KeyPressEventsTestHelper
  def z_key_press_event
    key_press_event(Qt::Key_Z, "z")
  end

  def shift_key_press_event
    key_press_event(Qt::Key_Shift)
  end

  def backspace_key_press_event
    key_press_event(Qt::Key_Backspace)
  end

  def return_key_press_event
    key_press_event(Qt::Key_Return)
  end

  def key_press_event(key, text="")
    Qt::KeyEvent.new(Qt::Event::KeyPress, key, Qt::NoModifier, text)
  end
end
