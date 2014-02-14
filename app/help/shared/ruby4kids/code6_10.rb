if @y > @game_window.height
  @y = 0
	@x = rand(@game_window.width)
else
  @y = @y + 10
end


