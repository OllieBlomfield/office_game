function add_key(x,y)
    level_has_key = true
    add(entities,{
        x=x,
        y=y,
        h=8,
        w=8,
        update=key_update,
        draw=key_draw,
        following=false,
    })
end

function key_update(e)
    if not e.following and coll(plr,e) then
        key_collected = true
        e.following = true
    end

    if e.following then
        e.x = plr.x
        e.y = plr.y-5
    end
end

function key_draw(e)
    spr(64,e.x+1,e.y + (e.following and 0 or min(1,2*sin(t/260))))
end