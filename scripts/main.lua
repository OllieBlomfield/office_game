function _init()
  t=0
  lvl=1
  debug_menu=false
  reset_level()
end

function _update60()
    t+=1
    if level_state==0 then
      level_intro()
    elseif level_state==1 then
      level_play()
    elseif level_state==2 then
      level_outro()
    end

    if btnp(5) then
      debug_menu = not debug_menu
    end
end 

function _draw()
    cls(7)
    set_pal()
    draw_background()
    rect(0,0,127,127,1)
    map(mx,my,0,0,16,16,127)
    
    for p in all(particles) do
      p.draw(p)
    end
    for e in all(entities) do
      e.draw(e)
    end
    if plr.visible then plr_draw() end

    if debug_menu then
      draw_debug()
    end
    --print(plr.state)
    --print(#objects)
    -- for e in all(entities) do
    --   rect(e.x,e.y,e.x+e.w,e.y+e.h,11)
    -- end
    -- for o in all(objects) do
    --   rect(o.x,o.y,o.x+o.w,o.y+o.h,11)
    -- end
    
    --circfill(plr.x+4,plr.y+4,cos(time()/4)*300,0 | 0x1800)
    if level_state==0 or level_state==2 then
      --fillp(░)
      poke(0x5f34,0x2)
      for i=1,5 do
        circfill(plr.x+3,plr.y+3,i*0.08*level_anim_time*level_anim_time, ({8,11,12,14,1})[i] | 0x1800)
      end
    end
    --circfill(plr.x+3, plr.y+3, 2, 0 | 0x1800)


    draw_foreground()
end
--{1,12,8,11,1}


function draw_debug()
  print(#particles,10,10,1)
  print(mx)
  print(my)
  print(level_anim_time)
end

function level_intro()
  level_anim_time = t - level_anim_start_time
  if level_anim_time > 40 then
    level_state = 1
  end
end

function level_play()
  plr_update()
  for e in all(entities) do
    e.update(e)
  end
  for p in all(particles) do
    p.update(p)
    p.l-=1
    if p.l <= 0 then
      del(particles,p)
    end
  end
end

function level_outro()
  level_anim_time = level_anim_start_time - t
  if level_anim_time < 0 then
    reset_level()
  end
end