function _init()
  t=0
  lvl = 1
  level_timer = 0
  debug_menu=false
  
  menu_init()
end

function _update60() update() end
function _draw()
  set_pal()
  draw()

  fade(0)
  draw_foreground()
end

--{1,12,8,11,1}

