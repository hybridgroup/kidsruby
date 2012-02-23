def button_down(id)
  if id == Gosu::Button:KbP
    if @pause == false
      @pause = true
    else
      @pause = false
    end
  end
end

