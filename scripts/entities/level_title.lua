function add_level_title(txt) 
    add(entities, {
        txt = txt,
        x=0,
        y=-10,
        w=8,
        h=8,
        anim_time=t,
        update = level_title_update,
        draw = level_title_draw,
    })
end

function level_title_update(e)
    if t - e.anim_time < 200 then
        e.y = lerp(-10,60,(t-e.anim_time)/100, ease_out_overshoot)
    end
    -- if t%5==2 then 
    --     add_dust(64-#e.txt*2,e.y) 
    --     add_dust(60+#e.txt*2,e.y)
    -- end
    --e.anim_time-=1
end

function level_title_draw(e)
    center_print(e.txt,e.y,7,"\^o0ff")
end