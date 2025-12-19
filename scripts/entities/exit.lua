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
        w=8,
        h=16,
        update=exit_update,
        draw=exit_draw,
        --particles=temp_particles,
        active=true,
        box={x=x+1,y=y+4,w=6,h=11}
    })
end

function exit_update(e)
    e.active = (not level_has_key) or (level_has_key and key_collected)
    if coll(plr,e.box) and e.active then
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
        
        clip(e.x,e.y,e.w,e.h)
        for i=7,2,-1 do
            local cl = flr(t/20)
            --local c = i==1 and 1 or i==2 and 7 or ({8,9,2})[(cl-i)%3+1]
            local c = ({8,9,8})[(cl-i)%3+1]
            --{8,9,2}{11,8,12}
            local x_center = e.x+e.w\2
            local y_center = e.y+e.h\2
            local x = x_center + 1 - i*2 + 3*cos((t+3*i)/120)
            local y = y_center + 6 - i*3 + 3*sin((t+3*i)/120)
            rrectfill(
                x,
                y,
                2*sin((t+3*i)/120)+4*i,
                2*cos((t+3*i)/120)+4*i,
                6,
                c
            )
        end
        clip()
        spr(21,e.x,e.y-1,1,0.125)
        rrect(e.x,e.y,e.w,e.h+1,0,1)
        rrect(e.x,e.y,e.w,e.h+1,2,1)
        -- local x_center = e.x+e.w\2
        -- local y_center = e.y+e.h\2
        -- circfill(x_center,y_center,9,8)
        -- local eye_off_x, eye_off_y =-(e.x-plr.x)/25, -(e.y-plr.y)/25
        -- --circfill(e.x + eye_off_x, e.y + eye_off_y, 3, 1)
        -- spr(14,x_center+eye_off_x,y_center+eye_off_y)
    else
        spr(21,e.x,e.y-1,1,0.125)
        rrect(e.x,e.y,e.w,e.h+1,0,1)
        rrectfill(e.x,e.y,e.w,e.h+1,2,1)
        spr(65,e.x,e.y+1,1,2)
    end
end