function add_break_block(x,y)
    add(entities,{
        x=x+3,
        y=y-1,
        w=3,
        h=6,
        update=break_block_update,
        draw=break_block_draw,
        state=0, --0 solid, 1 triggered, 2 breaking, 3 reseting
        anim_time = 0
    })
end

function break_block_update(e)
    if e.state==0 and coll(plr,e) then
        e.state = 1
    end
    if e.state==1 and not coll(plr,e) then
        e.state=2
        e.anim_time = 0
    end

    if e.state==2 then
        e.anim_time+=1
        if e.anim_time>=100 and not coll(plr,e) then
            e.anim_time=40
            e.state = 3
        end
    end
    
    if e.state==3 then
        e.anim_time-=1
        if e.anim_time==0 then
            set_break_block_tile(e,60)
            e.state=0
            --reset_break_block(e)
        end
    end

    if e.state>=2 then
        --mset(e.x\8+mx,(e.y+1)\8+my,({61,62,63,47})[min(4,1+e.anim_time\10)])
        set_break_block_tile(e,({61,62,63,47})[min(4,1+e.anim_time\10)])
    end

    if level_state == 2 then
        --mset(e.x\8+mx,(e.y+1)\8+my,60)
        set_break_block_tile(e,60)
        e.state=0
        --reset_break_block(e)
    end
end

function set_break_block_tile(e,s)
    mset(e.x\8+mx,(e.y+1)\8+my,s)
end

-- function reset_break_block(e)
--     set_break_block_tile(e,60)
--     e.state=0
-- end

function break_block_draw(e)
    --print(e.x\8+mx,(e.y+1)\8+my)
end