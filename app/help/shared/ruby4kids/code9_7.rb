def restart_game
  @running = true
  @balls.each {|ball| ball.reset!}.reset!
end
