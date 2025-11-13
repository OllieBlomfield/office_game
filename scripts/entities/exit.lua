function add_exit(x,y)
    -- temp_particles = {}
    -- for i=0,13 do
    --     add(temp_particles,{
    --         dir=rnd({-1,-0.5,0.5,1}),
    --         x=rnd({-2,-1,1,2})*(rnd(2)+1),
    --         y=rnd({-2,-1,1,2})*(rnd(2)+1),
    --         c=rnd({0,8,8,10,10,11,11,12,12}),
    --         sx=rnd(3),
    --         sy=rnd(3)
    --     })
    -- end


    add(entities,{
        x=x,
        y=y,
        w=12,
        h=12,
        update=exit_update,
        draw=exit_draw,
        --particles=temp_particles,
        active=true,
    })
end

function exit_update(e)
    e.active = (not level_has_key) or (level_has_key and key_collected)
    if coll(plr,e) then
        next_level()
    end
end

-- function exit_draw(e)
--     --ovalfill(exit.x,exit.y,exit.x+exit.w,exit.y+exit.h,0)
--     if e.active then
--         local center_x = e.x+e.w\2
--         local center_y = e.y+e.h\2
--         for p in all(e.particles) do
--             off_x=2*sin((t+rnd(20))/100)
--             off_y=2*cos((t+rnd(20))/100)
--             rectfill(
--             p.x+center_x+off_x*p.dir,
--             p.y+center_y+off_y*p.dir,
--             p.x+center_x+p.sx+rnd(2)+off_x*p.dir,
--             p.y+center_y+p.sy+rnd(2)+off_y*p.dir,
--             p.c)
--         end
--         spr(rnd({45,46,47}),e.x,e.y,1,2)
--     else
--         spr(65,e.x,e.y,1,2)
--     end
-- end

function exit_draw(e)
    if e.active then
        for i=6,2,-1 do
            rr = rrectfill
            if i==5 then
                rr=rrect
            end
            local c = i==5 and 1 or 0
            i = min(i,5)
            -- r = i*0.05*(t%120)
            -- circfill(e.x+4,e.y+8,r/2,({8,11,12,14,1})[flr(r)\2])
            local cl = flr(t/20)
            -- circfill(e.x+4,e.y+8,i*2,({8,11,12,14,1})[(c-i)%5+1])
            -- local x = e.x + 4 + 3*cos((t+3*i)/80)
            -- local y = e.y + 8 + 3*sin((t+3*i)/80)
            -- circfill(x,y,i*3,({7,8,7,6,8})[i])

            local x = e.x + 6 - i*2 + 3*cos((t+3*i)/120)
            local y = e.y + 6 - i*2 + 3*sin((t+3*i)/120)
            rr(
                x,
                y,
                2*sin((t+3*i)/120)+i*4,
                2*cos((t+3*i)/120)+i*4,
                6,
                ({1,7,10,9,8,2})[(cl-i)%5+1]
            )
            -- circfill(
            --     x,
            --     y,
            --     2*sin((t+3*i)/120)+i*4,
            --     ({1,7,10,9,8,2})[i + c]
            -- )
            --{7,8,7,8,2,1}
            --circfill(x,y,i*3,({7,8,7,6,8})[i])
        end
    else
        spr(65,e.x,e.y,1,2)
    end
end