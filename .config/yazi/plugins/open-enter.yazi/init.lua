-- open-enter: open directory in Thunar, or open file with default program
-- Used for Enter key
return {
  entry = function()
    local h = cx.active.current.hovered
    if h then
      if h.cha.is_dir then
        -- Open directory in Thunar
        local path = tostring(h.url)
        os.execute('thunar "' .. path .. '" &')
      else
        ya.manager_emit("open", {})
      end
    end
  end,
}
