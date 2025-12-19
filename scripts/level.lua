levels = {}
levels[1] = {{10,112}, {104,8}, "just a bit of jumping",20, 
function() 
  print("TAP❎",10,97,13)
  draw_curve({28,116},{40,82},{52,108},10,13)
  print("HOLD❎",58,97,13)
  draw_curve({76,116},{90,76},{100,92},10,13)
  print("EXIT",80,13)
  spr(68,96,13)
end}
levels[2] = {{16,112}, {108,8}, "now spikes",20}
levels[3] = {{16,112}, {12,8}, "stop n' start",20}
levels[4] = {{9,112}, {104,8}, "don't stop",20}
levels[5] = {{16,112}, {104,16}, "grab the key!",20}
levels[6] = {{9,112}, {12,16}, "rebound",20}
levels[7] = {{61,112}, {84,24}, "ghosts n' ghouls",20}
levels[8] = {{16,112}, {110,24}, "fragile stuff",20}
levels[9] = {{16,64}, {12,104}, "end of demo :)",20}
levels[10] = {{104,104}, {12,8}, "hot stuff",20}
levels[11] = {{16,112}, {108,8}, "test2",20}
levels[12] = {{16,112}, {110,104}, "test",20} --at 3 possible stars for beating level in certain time

function reset_level() --fix mx and my
    level_state = 0 --0 intro, 1 playing, 2 clear
    mx = ((lvl-1)%8)*16
    my = 48*((lvl-1)\8)
    current_lvl=levels[lvl]
    objects = {}
    entities = {}
    particles = {}
    plr_init(current_lvl[1][1],current_lvl[1][2])
    level_has_key = false
    key_collected = false
    level_cleared = false
    level_anim_start_time = t
    level_anim_time = 0

    timer_start_time = time()
    level_timer = 0
    scan_map()
    
    -- if current_lvl[3] then
    --     current_lvl[3]()
    -- end
    add_level_title(current_lvl[3])
    add_exit(current_lvl[2][1],current_lvl[2][2])
end

function next_level()
    lvl+=1
    level_cleared = true
    transition_out_level()
end

function transition_out_level()
    level_state = 2
    level_anim_start_time = t + 40
end

function level_intro()
  entity_update()
  level_anim_time = t - level_anim_start_time
  if level_anim_time > 60 then
    level_state = 1
  end
end

function level_play()
  level_timer = time() - timer_start_time
  plr_update()
  entity_update()
  for p in all(particles) do
    p.update(p)
    p.l-=1
    if p.l <= 0 then
      del(particles,p)
    end
  end
end

function level_outro()
  -- if plr.visible then
  --   plr.visible = false
  --   add_pop(plr.x+4,plr.y+4)
  -- end
  level_anim_time = level_anim_start_time - t
  if level_anim_time < -2 then
    if level_cleared then
      transition_init()
    else
      reset_level()
    end
  end
end

function level_init()
  reset_level()
  update = level_update
  draw = level_draw
end

function level_update()
    t+=1
    for p in all(particles) do
      p.update(p)
      p.l-=1
      if p.l <= 0 then
        del(particles,p)
      end
    end
    if level_state==0 then
      level_intro()
    elseif level_state==1 then
      level_play()
    elseif level_state==2 then
      level_outro()
    end

    if btnp(4) then
      debug_menu = not debug_menu
    end
end 

function level_draw()
    cls(7)
    draw_background()
    rect(0,0,127,127,1)

    if current_lvl[5] then current_lvl[5]() end
    for p in all(particles) do p.draw(p) end
    map(mx,my,0,0,16,16,127)
    
    
    for e in all(entities) do e.draw(e) end
    if plr.visible then plr_draw() end
    
    if debug_menu then
      draw_debug()
    end

    
    --print(plr.state)
    --print(#objects)
    
    --circfill(plr.x+4,plr.y+4,cos(time()/4)*300,0 | 0x1800)
    if level_state==0 or level_state==2 then
      --fillp(░)
      poke(0x5f34,0x2)
      for i=1,5 do
        circfill(plr.x+3,plr.y+3,i*0.08*level_anim_time*level_anim_time, ({8,11,12,10,1})[i] | 0x1800)
      end
    end
    --circfill(plr.x+3, plr.y+3, 2, 0 | 0x1800)
    --print(timer,10,10,0)

    --draw_foreground()
end
