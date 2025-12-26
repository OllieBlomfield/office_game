function _init()
  t=0
  lvl = 12
  sfx_time = 0
  level_timer = 0
  debug_menu=false
  
  menu_init()
end

function _update60()
  sfx_time = max(sfx_time-1,0) 
  update() 
end
function _draw()
  set_pal()
  draw()

  fade(0)
  draw_foreground()
end

--{1,12,8,11,1}

