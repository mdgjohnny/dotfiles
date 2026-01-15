-- smart-enter: navigate into directory or open file with default program
-- Used for l/arrow keys - always navigates into dirs
return {
  entry = function()
    local h = cx.active.current.hovered
    if h then
      if h.cha.is_dir then
        ya.manager_emit("enter", {})
      else
        ya.manager_emit("open", {})
      end
    end
  end,
}
