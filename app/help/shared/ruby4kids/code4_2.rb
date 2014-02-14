def move_left
  if @x < 0
    @x = 0 
  else
    @x = @x - 10
  end
end

