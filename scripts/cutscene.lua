intro_scenes = {
        {"jimbo was working hard.", function() spr(t%40>20 and 32 or 34,80,44) map(0,16,28,29,9,4) end},
        {"but not hard enough!",
        function()
            --map(0,16,28,29,9,4)
            map(0,16,28,29,9,4,0x40)
            clip(28,29,72,32)
            for i=7,2,-1 do
                local cl = flr(t/20)
                --local c = i==1 and 1 or i==2 and 7 or ({8,9,2})[(cl-i)%3+1]
                local c = ({8,9,2})[(cl-i)%3+1]
                --{8,9,2}{11,8,12}
                local x_center = 45
                local y_center = 46
                local x = x_center + 1 - i*2 + 3*cos((t+3*i)/120)
                local y = y_center + 6 - i*3 + 3*sin((t+3*i)/120)
                rrectfill(
                    x,
                    y,
                    2*sin((t+3*i)/120)+4*i,
                    2*cos((t+3*i)/120)+4*i,
                    6,
                    c
                )
            end
            --print(flr(fizz),14,20)
            --fizz+=0.05
            spr_r(16,44,44,4*t%360,1,1)
            map(0,16,28,29,9,4,0x3)
         end},
        {"jimbo must be punished", function()
            clip(28,29,72,32)
            map(0,20,28,29,9,4)
            local sp_modifier = t%30>15 and 1 or 0
            spr(1,37,45,0.75,1,t%60>30)
            lava_draw({x=68,y=54})
            lava_draw({x=76,y=54})
            line(64,60,84,60,1)
        end},
        level_init
}

outro_scenes = {
    {"good job jimbo!", function() 
        for i=0,4 do
            lava_draw({x=12+8*i,y=54})
        end
        map(0,24,28,15,12,8)  
        line(12,62,84,62,1)
        print("EXIT",68,47,13)
        spr(68,84,47)
        spr(t%30>15 and 32 or 34,60,47)
    end},
    {"now you can get back to work",function() spr(t%40>20 and 1 or 2,80,44) map(0,16,28,29,9,4) end},
    {"congratulations!!!", function() 
        spr(70,40,38)
        print(":"..num_deaths,48,40,1)
        spr(72,40,48)
        print(":"..game_timer.."s",48,50,1)
        spr(1,61,60,0.75,1,t%60>30) 
        spr(71,72,60,0.75,1,t%60>30) 
        spr(71,50,60,0.75,1,t%60>30) 
    end},
    function()
        set_default_globals()
        dset(0,0)
        menu_init()
    end
}

function cutscene_init(content)
    scenes = content
    update = cutscene_update
    draw = cutscene_draw
    t=0
    particles = {}

    fizz = 0
    current_screen = 1
    cutscene_state = 0 --0 trans in, 1 show intro screen, 2 trans out, 3 to game
    fade_in = 20
    music(1,30)
end

function cutscene_update()
    t+=1
    for p in all(particles) do
        p.update(p)
        p.l-=1
        if p.l <= 0 then
        del(particles,p)
        end
    end
    if cutscene_state==0 then
        fade_in = max(fade_in-0.5,0)
        if fade_in==0 then cutscene_state=1 end
    elseif cutscene_state==1 then
        if btnp(5) then
            cutscene_state=2
        end
    elseif cutscene_state==2 then
        fade_in = min(fade_in+0.5,18)
        if fade_in==18 then
            current_screen+=1
            if current_screen > #scenes-1 then
                scenes[#scenes]()
            else
                cutscene_state=0
            end
        end
    end
end

function cutscene_draw()
    cls(1)
    if cutscene_state==1 then
        set_pal()
    else
        fade(fade_in)
    end

    clip(14,20,100,50)
    rrectfill(14,20,100,50,3,7)
    draw_background()
    for p in all(particles) do p.draw(p) end
    scenes[current_screen][2]()
    clip()
    
    local px,py = center_print(scenes[current_screen][1],76,6)
    if t>120 then print("\^o0ff❎continue",86,118,7) end
end

fadeTable={
{0,0,0,0,0,0,0,0,129,129,129,129,129,129,129},
 {1,1,1,1,1,1,1,1,129,129,129,129,129,129,129},
 {136,136,136,2,2,2,2,2,130,130,130,130,130,129,129},
 {3,3,3,3,131,131,131,131,131,131,1,129,129,129,129},
 {4,4,4,132,132,132,132,133,133,133,133,130,130,129,129},
 {134,134,134,141,141,5,5,5,5,133,133,133,1,1,129},
 {6,6,6,13,13,13,13,13,5,5,5,133,1,1,129},
 {7,6,6,6,6,134,13,13,13,141,5,5,133,1,1},
 {8,8,136,136,136,136,2,2,2,2,130,130,130,130,129},
 {9,9,9,4,4,4,4,4,132,132,132,133,133,130,129},
 {10,10,138,138,138,138,4,4,5,5,5,133,133,133,129},
 {139,139,3,3,3,3,3,3,131,131,131,131,129,129,129},
 {12,12,12,140,140,140,140,140,140,131,131,131,1,1,129},
 {13,13,13,141,141,141,5,5,5,133,1,1,1,1,129},
 {143,143,134,134,134,134,134,141,141,5,5,133,133,130,129},
 {15,15,143,134,134,134,134,134,141,5,5,5,133,1,129}
}


function fade(i)
 for c=0,15 do
  if flr(i+1)>=16 then
   pal(c,17)
  else
   pal(c,fadeTable[c+1][flr(i+1)])
  end
 end
end

function intro_cutscene()
    cutscene_init(intro_scenes)
end

function outro_cutscene()
    cutscene_init(outro_scenes)
end