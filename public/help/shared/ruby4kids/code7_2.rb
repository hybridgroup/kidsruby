def hit_by?(ball)
   Gosu::distance(@x, @y, ball.x, ball.y) < 50
end
