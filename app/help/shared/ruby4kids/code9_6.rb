def hit_by?(balls)
  balls.any? {|ball| Gosu::distance(@x, @y, ball.x, ball.y) < 50}
end
