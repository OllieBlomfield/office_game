function add_ghost(x,y)
    add(entities,{
        x=x,
        y=y,
        h=7,
        w=8,
        origin_y=y,
        update=ghost_update,
        draw=ghost_draw,
        box = {x = x+1, y=y+1,w=6,h=6}
    })
end

function ghost_update(e)
    e.y = e.origin_y + 16*sin(t/260)
    e.box = {x = e.x+1, y=e.y+2,w=6,h=5}
    damage_plr_on_hit(e.box)
end

function ghost_draw(e)
    spr(cos(t/260) > 0 and 20 or 22,e.x,e.y)
    sspr(40,t%30>15 and 9 or 11,8,2,e.x,e.y+6)
end