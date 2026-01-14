function level_select_init()
    update = level_select_update
    draw = level_select_draw
    t=0
    level_positions = {}

    level_select_state = 0 --0 transition in, 1 main, 2 trainsition out
    for y=0,2 do
        if y==1 then
            for x=4,0,-1 do
                level_positions[#level_positions+1] = {x,y}
            end
        else
            for x=0,4 do
                level_positions[#level_positions+1] = {x,y}
            end
        end
    end

    unlocked_levels = max_level
    selected_level = min(lvl,15)
    loc_x = level_positions[selected_level][1]
    loc_y = level_positions[selected_level][2]

    next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)

    
    moving = false
    goal_x = 0
    goal_y = 0
    og_x = 0
    og_y = 0
    move_time = 0  

    level_select_transition_start = 0
    level_select_transition_time = 0

    play_song(4)
end

function level_select_update()
    t+=1
    if level_select_state == 0 then
        level_select_transition_time = t - level_select_transition_start
        if level_select_transition_time > 60 then
            level_select_state = 1
        end
    elseif level_select_state == 1 then
        if not moving then
            level_select_input()
        end

        if moving and t-move_time < 16 then
            loc_x = lerp(og_x,goal_x,(t-move_time)/15)
            loc_y = lerp(og_y,goal_y,(t-move_time)/15)
        else
            moving = false
        end
    else --when state is 2 (or more which it shouldnt be able to do!)
        level_select_transition_time = level_select_transition_start - t
        if level_select_transition_time < -2 then
            level_init()
        end
    end
end

function level_select_draw()
    cls(7)
    draw_background()
    map(16,16,12,30)
    for i=1,15 do
        local col = i < unlocked_levels and 11 or (i == unlocked_levels and 9) or 8
        rrectfill(level_positions[i][1]*24+13,level_positions[i][2]*32+39,6,6,0,col)
    end

    print("EXIT",104,110,6)
    spr(83,120,110)

    spr(({33,34,35,34})[1+(t%60\15)],13+loc_x*24,34+loc_y*32)

    center_print("level:"..selected_level,10,7,"\^o0ff")
    center_print(levels[selected_level][3],18,7,"\^o0ff")

    if level_select_state==0 or level_select_state==2 then
      --fillp(░)
      poke(0x5f34,0x2)
      for i=1,5 do
        circfill(16+loc_x*24,32*loc_y+37,i*0.08*level_select_transition_time*level_select_transition_time, ({8,11,12,10,1})[i] | 0x1800)
      end
    end
end


function calc_valid_direction(a)
    local out_1 = a+1 <= unlocked_levels and calc_level_direction(a,a+1) or {0,0}
    local out_2 = a-1 >= 1 and calc_level_direction(a,a-1) or {0,0}
    return out_1, out_2
end

function calc_level_direction(p1,p2)
    local p1 = level_positions[p1]
    local p2 = level_positions[p2]

    return {p2[1]-p1[1],p2[2]-p1[2]}
end

function move_on_board(x,y)
    moving = true
    og_x = loc_x
    og_y = loc_y

    goal_x,goal_y = x,y
    move_time = t
end

function level_select_input()
    if btnp(➡️) then
        if next_valid_direction[1]==1 then
            selected_level+=1
            move_on_board(loc_x+1,loc_y)
            next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)
        end

        if prev_valid_direction[1]==1 then
            selected_level-=1
            move_on_board(loc_x+1,loc_y)
            next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)
        end
    end

    if btnp(⬅️) then
        if next_valid_direction[1]==-1 then
            selected_level+=1
            move_on_board(loc_x-1,loc_y)
            next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)
        end

        if prev_valid_direction[1]==-1 then
            selected_level-=1
            move_on_board(loc_x-1,loc_y)
            next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)
        end
    end

    if btnp(⬇️) then
        if next_valid_direction[2]==1 then
            selected_level+=1
            move_on_board(loc_x,loc_y+1)
            next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)
        end

        if prev_valid_direction[2]==1 then
            selected_level-=1
            move_on_board(loc_x,loc_y+1)
            next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)
        end
    end

    if btnp(⬆️) then
        if next_valid_direction[2]==-1 then
            selected_level+=1
            move_on_board(loc_x,loc_y-1)
            next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)
        end

        if prev_valid_direction[2]==-1 then
            selected_level-=1
            move_on_board(loc_x,loc_y-1)
            next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)
        end
    end

    if btnp(❎) then
        lvl = selected_level
        level_select_transition_start = t + 40
        level_select_state = 2
        sfx(11)
    end
end

menuitem(3,"level select",level_select_init)