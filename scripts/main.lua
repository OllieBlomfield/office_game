function _init()
  cartdata("office_hell_ob")
  t=0
  set_default_globals()
  if dget(0)!=0 then
    load_game()
  end

  sfx_time = 0
  level_timer = 0
  debug_menu=false
  
  menu_init(0)
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

