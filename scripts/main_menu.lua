function menu_init()
    update = menu_update
    draw = menu_draw
    
    fade_in = 20
    options = {"play"}
    logo_offset_y = 0
    new_game = false
    menu_state = 1 --0 credits, 1 logo, 2 game transition, 3 intro transition
    menu_credit_fade_state = 0 --0 fade_in, 1 fade out

    --intro_transition vars
    intro_transition_time = 0
    intro_circle_size = 110
end

function menu_update()
    if menu_state==0 then
        if menu_credit_fade_state==0 then
            fade_in = max(-15,fade_in-0.5)
            if fade_in==-15 then
                menu_credit_fade_state = 1
            end
        elseif menu_credit_fade_state==1 then
            fade_in = min(20,fade_in+0.5)
            if fade_in==20 then
                menu_state=1
            end
        end
    elseif menu_state==1 then
        fade_in = max(0, fade_in-0.5)
        if btnp(4) and fade_in==0 then menu_state = new_game and 3 or 2 end
    elseif menu_state==2 then
        logo_offset_y-=6
        if logo_offset_y < -60 then
            level_init()
        end
    elseif menu_state==3 then
        intro_transition_time+=1
        intro_circle_size = lerp(95,-2,intro_transition_time/100)
        if intro_transition_time > 100 then
            intro_init()
        end
    end
end

function menu_draw()
    cls(1)
    fade(max(0,fade_in))
    if menu_state==0 then
        center_print("by ob",60,7,"\^o0ff")
    elseif menu_state>=1 then
        fillp(░)
        poke(0x5f34,0x2)
        circfill(64,67,70,0 | 0x1800)
        fillp()
        center_print("x to "..(new_game and "start" or "continue"), 80, 7,"\^o0ff")
        draw_logo()
        circfill(63,63,intro_circle_size,1 | 0x1800)
        circ(63,63,intro_circle_size - 1 , 7)
    end

    
end

function draw_logo()
    spr(96,28,20 + logo_offset_y,9,2)
    spr(73,37,30 + logo_offset_y,5,4)
    spr(78,74,29 + logo_offset_y,2,4)
    spr(78,86,29 + logo_offset_y,2,4)
end