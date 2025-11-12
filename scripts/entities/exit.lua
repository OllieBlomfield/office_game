function add_exit(x,y)
    temp_particles = {}
    for i=0,13 do
        add(temp_particles,{
            dir=rnd({-1,-0.5,0.5,1}),
            x=rnd({-2,-1,1,2})*(rnd(2)+1),
            y=rnd({-2,-1,1,2})*(rnd(2)+1),
            c=rnd({0,8,8,10,10,11,11,12,12}),
            sx=rnd(3),
            sy=rnd(3)
        })
    end


    add(entities,{
        x=x,
        y=y,
        w=8,
        h=16,
        update=exit_update,
        draw=exit_draw,
        particles=temp_particles,
        active=true,
    })
end

function exit_update(e)
    e.active = (not level_has_key) or (level_has_key and key_collected)
    if coll(plr,e) then
        next_level()
    end
end

function exit_draw(e)
    --ovalfill(exit.x,exit.y,exit.x+exit.w,exit.y+exit.h,0)
    if e.active then
        local center_x = e.x+e.w\2
        local center_y = e.y+e.h\2
        for p in all(e.particles) do
            off_x=2*sin((t+rnd(20))/100)
            off_y=2*cos((t+rnd(20))/100)
            rectfill(
            p.x+center_x+off_x*p.dir,
            p.y+center_y+off_y*p.dir,
            p.x+center_x+p.sx+rnd(2)+off_x*p.dir,
            p.y+center_y+p.sy+rnd(2)+off_y*p.dir,
            p.c)
        end
        spr(rnd({45,46,47}),e.x,e.y,1,2)
    else
        spr(65,e.x,e.y,1,2)
    end
end