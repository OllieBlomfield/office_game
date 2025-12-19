function plr_init(x,y)
  SLOW_GRAVITY = 0.05
  NORMAL_GRAVITY = 0.17
  MAX_Y_VELOCITY = 2
  NO_STOP_AMOUNT = 33
  COYOTE_TIME = 12
  
  plr = {
    x=x,
    y=y,
    dx=0,
    dy=0,
    h=8,
    w=6,
    dir = x < 64 and 1 or -1,
    state = 0, --0 still, 1 moving, 2 death
    death_state = 0, --0 start, 1 shaking, 2 explode, 3 done
    death_anim_start_time = 0,
    visible = true,
    jumping = false,
    jumpheld = false,
    grounded = true,
    already_hit_on_y = false,
    jumpfrc = 1.7,
    jmp_buffer = 0,
    coy_time = 0,
    gravity = NORMAL_GRAVITY,
    spd = 0.5,
    no_stop_delay = 0,
    draw_offset_x=0,
    draw_offset_y=0,
  }
end

function plr_update()
  handle_gravity()
  plr.no_stop_delay = max(plr.no_stop_delay-1, 0)

  if plr.state==0 then
    plr_stop_state()
  elseif plr.state==1 then
    plr_move_state()
  elseif plr.state==2 then
    plr_death_state()
  end

  

  plr.x += plr.dx
  plr.y -= plr.dy
end

function plr_draw()
  local sp = 32
  if plr.state==0 then
    print("⬅️",plr.x-8,plr.y+2,1)
    print("➡️",plr.x+7,plr.y+2)
  end

  if plr.state==1 then
    if plr.dy==0 then
      sp = ({33,34,35,34})[1+(t%60\15)]
    end
  -- elseif plr.state==0 then
  --   sp = ({32,34})[1+(t%60\30)]
  end

  --if running out of sprite space, draw both walking sprites at same position
  spr(sp,plr.x+plr.draw_offset_x,plr.y+plr.draw_offset_y,0.875,1,plr.dir<0)
end

function handle_gravity()
  --plr.already_hit_on_y = false
  if plr.jumpheld then
    plr.gravity = SLOW_GRAVITY
  else
    plr.gravity = NORMAL_GRAVITY
  end

  if not plr.grounded then
    plr.dy = max(plr.dy - plr.gravity, -MAX_Y_VELOCITY)
    plr.coy_time -= 1
  else
    plr.coy_time = COYOTE_TIME
  end

  if (collide_map(plr,"down",1) or plr.y+plr.h>=127) and plr.dy <= 0 then
    --if not plr.grounded then plr.already_hit_on_y = true end
    plr.dy = 0
    plr.y-=((plr.y+plr.h+1)%8)-1
    plr.grounded = true
    plr.jumping = false
    plr.jumping = false
  else
    plr.grounded = false
  end

end

function plr_move_state()
  plr.dx = plr.spd * plr.dir

  if t%20>14 and plr.grounded then add_dust(plr.x+3,plr.y+8) end

  if btnp(5) then plr.jmp_buffer = 6 else plr.jmp_buffer -= 1 end

  if plr.jmp_buffer>0 and not plr.jumping and plr.coy_time > 0 then --doesnt check grounded
    add_dust(plr.x,plr.y+8)
    add_dust(plr.x+7,plr.y+8)
    plr.jumping = true
    plr.jumpheld = true
    plr.dy=plr.jumpfrc
    plr.gravity = SLOW_GRAVITY
  end

  if plr.jumpheld and not btn(5) then plr.jumpheld=false end

  if (collide_map(plr,"up",0) or plr.x<0) and plr.dy>0 then
    plr.dy = 0
    plr.y-=((plr.y+plr.h+1)%8)-1
  end


  if collide_map(plr,"left",0) or plr.x<0 then
      plr.dir=1
  end
  if collide_map(plr,"right",0) or plr.x>128-plr.w then
      plr.dir=-1
  end
  

  for o in all(objects) do
    if coll(plr,o) then
        o.func()
    end
  end
end

function plr_stop_state()
    if btnp(1) then
        plr.dir = 1
        plr.state = 1
        plr.no_stop_delay = NO_STOP_AMOUNT
    end
    if btnp(0) then
        plr.dir = -1
        plr.state = 1
        plr.no_stop_delay = NO_STOP_AMOUNT
    end
end

function plr_death_state()
  plr.dx=0
  plr.dy=0
  if plr.death_state==0 then --start
    plr.death_anim_start_time = t
    plr.death_state=1
  elseif plr.death_state==1 then --shaking
    plr.draw_offset_x=rnd(1)-0.5
    plr.draw_offset_y=rnd(1)-0.5
    plr.dir = rnd({-0.01,0.01})
    if t - plr.death_anim_start_time > 28 then
      plr.death_state=2
    end
  elseif plr.death_state==2 then --explode
    plr.visible = false
    add_pop(plr.x+4,plr.y+4)
    plr.death_state=3
  elseif plr.death_state==3 then
    if btnp(5) then transition_out_level() end
  end
end

function plr_damage()
  plr.state=2
end