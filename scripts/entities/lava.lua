function add_lava(x,y)
    add(entities,{
        x=x,
        y=y,
        h=8,
        w=8,
        update=lava_update,
        draw=lava_draw
    })
end

function lava_update(e)
    damage_plr_on_hit(e)
    --add_dust(e.x+rnd(5),e.y+rnd(4))
end

function lava_draw(e)
    --spr(23,e.x,e.y)
    for i=0,7 do
        -- pset(e.x+i,e.y-2*sin((t+e.x+i)/40),9)
        local y = 2*sin((t+e.x+i)/80) + sin((t/4+e.x+i)/20)
        pset(e.x+i,e.y+y,10)
        line(e.x+i,e.y+1+y,e.x+i,e.y+8,9)
        line(e.x+i,e.y+4+y*0.5,e.x+i,e.y+8,8)
        line(e.x+i,e.y+7+y*0.3,e.x+i,e.y+8,2)
    end
end