function add_ghost(x,y)
    add(entities,{
        x=x,
        y=y,
        h=7,
        w=8,
        origin_y=y,
        update=ghost_update,
        draw=ghost_draw
    })
end

function ghost_update(e)
    e.y = e.origin_y + 16*sin(t/260)
    damage_plr_on_hit(e)
end

function ghost_draw(e)
    spr(cos(t/260) > 0 and 20 or 22,e.x,e.y)
    sspr(40,t%30>15 and 9 or 11,8,2,e.x,e.y+6)
end