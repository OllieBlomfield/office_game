function add_spike(x,y)
    add(entities,{
        x=x+1,
        y=y+5,
        w=6,
        h=3,
        update=spike_update,
        draw=spike_draw,
        state=0,
        attack_time = 0
    })
end

function spike_update(e)
    e.attack_time = max(0,e.attack_time-1)

    if coll(plr,e) then
        if e.state==0 then e.state=1 sfx_time = 0 play_sfx(3,12) end
        if e.state==2 then plr_damage() end
    end

    if e.state==1 and not coll(plr,e) then
        --add_splurt(e.x+4,e.y+5)
        e.state=2
        e.attack_time=160
    end

    if e.state==2 and e.attack_time==0 then
        e.state = 0
    end
end

function spike_draw(e)
    if e.state==0 then
        line(e.x-1,e.y+3,e.x+6,e.y+3,8)
    elseif e.state==1 then
        line(e.x-1,e.y+3,e.x+6,e.y+3,8)
        spr(5,e.x-1,e.y-2,1,0.625)
    elseif e.state==2 then
        if e.attack_time < 5 then
            line(e.x-1,e.y+3,e.x+6,e.y+3,8)
            spr(5,e.x-1,e.y-2,1,0.625)
        else
            spr(5,e.x-1,e.y-4)
        end
    end
end