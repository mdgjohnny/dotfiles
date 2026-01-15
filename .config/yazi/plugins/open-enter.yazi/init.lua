-- open-enter: open directory in Thunar, or open file with default program
-- Used for Enter key
return {
  entry = function()
    local h = cx.active.current.hovered
    if h then
      if h.cha.is_dir then
        -- Open directory in Thunar using yazi's child process spawning
        local child, err = Command("thunar"):arg(tostring(h.url)):spawn()
      else
        ya.manager_emit("open", {})
      end
    end
  end,
}
