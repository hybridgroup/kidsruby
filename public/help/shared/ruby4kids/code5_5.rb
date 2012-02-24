def move_up
  if @y < 0
    @y = 0
  else 
    @y = @y - 10
  end
end
