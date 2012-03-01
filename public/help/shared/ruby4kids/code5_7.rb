def move_down 
  if @y > (@game_window.height - 75)
    @y = @game_window.height -75
  else
    @y = @y + 10
  end
end
