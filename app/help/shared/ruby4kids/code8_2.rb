else
  #the game is currently stopped
  if button_down? Gosu:Button:KbEscape
    restart_game
  end
end

