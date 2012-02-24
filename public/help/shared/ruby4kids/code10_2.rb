def update
  if @pause == false
    if button_down? Gosu::Button::KbLeft
