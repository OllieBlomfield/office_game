function menu_init()
    update = menu_update
    draw = menu_draw

    options = {"play"}
    logo_offset_y = 0
    menu_state = 1 --0 credits, 1 logo, 2 game transition
end

function menu_update()
    if menu_state==1 then
        if btnp(4) then menu_state = 2 end
    elseif menu_state==2 then
        logo_offset_y-=6
        if logo_offset_y < -60 then
            level_init()
        end
    end
end

function menu_draw()
    cls(1)
    -- rrect(22,68,84,54,6,7)
    -- rrectfill(24,70,80,50,6)
    -- for i=1,#options do
    --     print(options[i],26,72,1)
    -- end
    draw_logo()
    draw_foreground()
end

function draw_logo()
    spr(96,28,20 + logo_offset_y,9,2)
    spr(73,37,30 + logo_offset_y,5,4)
    spr(78,74,29 + logo_offset_y,2,4)
    spr(78,86,29 + logo_offset_y,2,4)
end