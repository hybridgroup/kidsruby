 def update
  if button_down? Gosu::Button::KbLeft
    @player1.move_left
  end

  if button_down? Gosu::Button::KbRight
    @player1.move_right
  end
end
