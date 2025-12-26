function level_select_init()
    update = level_select_update
    draw = level_select_draw
    t=0
    selected_level = 1
    level_positions = {}
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

    unlocked_levels = 15

    next_valid_direction, prev_valid_direction = calc_valid_direction(1)

    

    loc_x = 0
    loc_y = 0
end

function level_select_update()
    t+=1

    if btnp(➡️) then
        if next_valid_direction[1]==1 then
            selected_level+=1
            loc_x+=1
            next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)
        end

        if prev_valid_direction[1]==1 then
            selected_level-=1
            loc_x+=1
            next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)
        end
    end

    if btnp(⬅️) then
        if next_valid_direction[1]==-1 then
            selected_level+=1
            loc_x-=1
            next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)
        end

        if prev_valid_direction[1]==-1 then
            selected_level-=1
            loc_x-=1
            next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)
        end
    end

    if btnp(⬇️) then
        if next_valid_direction[2]==1 then
            selected_level+=1
            loc_y+=1
            next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)
        end

        if prev_valid_direction[2]==1 then
            selected_level-=1
            loc_y-=1
            next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)
        end
    end

    if btnp(⬆️) then
        if next_valid_direction[2]==-1 then
            selected_level+=1
            loc_y-=1
            next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)
        end

        if prev_valid_direction[2]==-1 then
            selected_level-=1
            loc_y-=1
            next_valid_direction, prev_valid_direction = calc_valid_direction(selected_level)
        end
    end

    if btnp(❎) then
        lvl = selected_level
        level_init()
    end


    
    -- if btnp(➡️) then
    --     if selected_level+1 <= #level_positions and level_positions[selected_level][1]+1==level_positions[selected_level+1][1] then
    --         selected_level+=1
    --         loc_x+=1
    --     end
    -- end

    -- if btnp(⬅️) then
    --     if selected_level-1 >= 1 and level_positions[selected_level][1]-1==level_positions[selected_level-1][1] then
    --         selected_level-=1
    --         loc_x-=1
    --     end
    -- end

    -- if btnp(⬇️) then
    --     if selected_level+1 <= #level_positions and level_positions[selected_level][2]+1==level_positions[selected_level+1][2] then
    --         selected_level+=1
    --         loc_y+=1
    --     end
    -- end



end

function level_select_draw()
    cls(7)
    draw_background()
    map(16,16,12,30)
    for i=1,15 do
        local col = i < unlocked_levels and 11 or (i == unlocked_levels and 9) or 8
        rrectfill(level_positions[i][1]*24+13,level_positions[i][2]*32+39,6,6,0,col)
    end

    spr(({33,34,35,34})[1+(t%60\15)],13+loc_x*24,34+loc_y*32)

    center_print("level:"..selected_level,10,7,"\^o0ff")
    center_print(levels[selected_level][3],18,7,"\^o0ff")


    -- print(selected_level,10,10,1)
    -- print(next_valid_direction[1])
    -- print(next_valid_direction[2])

    


    -- for pos in all(level_positions) do
    --     print("HI",12+pos[1]*24,30+pos[2]*32)
    -- end

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

menuitem(3,"level select",level_select_init)