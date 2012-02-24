def draw
  @player1.draw
  @ball.draw
  @font.draw("The game is paused.", 50, 200, 10) if @pause == true
end
