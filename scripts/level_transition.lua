function transition_init()
    update = transition_update
    draw = transition_draw

    fast_enough = level_timer <= levels[max(1,lvl-1)][4]
    transition_anim_time = -10
end

function transition_update()
    transition_anim_time+=1
    if transition_anim_time>140 then
        level_init()
    end
end

function transition_draw()
    cls(1)
    --fillp(░)
    rrectfill(transition_anim_time-2,58,10,12,3,7 | 6)
    if fast_enough then
        local x = 56
        local y = 90 + 3*sin(transition_anim_time/100)
        rrectfill(x-1,y+2,18,9,1,0)
        rrectfill(x,y+7,16,3,0,9)
        spr(80,x,y,1,1,false)
        spr(80,x+8,y,1,1,true)
        --rectfill(x,y+7,x+7,y+10,9)
        
    end
    --fillp()
    spr(({33,34,35,34})[1+(transition_anim_time%60\15)],transition_anim_time,60)
    --print(lvl-1,3,52,13)
    --print(lvl,123,52,13)
    --draw_foreground()
end