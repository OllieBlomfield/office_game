function transition_init()
    update = transition_update
    draw = transition_draw

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
    --fillp()
    spr(({33,34,35,34})[1+(transition_anim_time%60\15)],transition_anim_time,60)
    draw_foreground()
end