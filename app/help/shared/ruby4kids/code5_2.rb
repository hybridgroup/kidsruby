def move_right
  if @x > (@game_window.width - 75)
    @x = @game_window.width - 75
  else
    @x = @x + 10
  end
end
