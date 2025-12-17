function intro_init()
    update = intro_update
    draw = intro_draw
    t=0
    current_intro_screen = 1
    intro_scene_state = 0 --0 trans in, 1 show intro screen, 2 trans out, 3 to game
    fade_in = 20
    intro_scenes = {
        {"there once was a little fellow", function() spr(1,30,30) end},
        {"named johnathen bellow haha good times fun times init hha luv", 
        function()
            for i=7,2,-1 do
                local cl = flr(t/20)
                --local c = i==1 and 1 or i==2 and 7 or ({8,9,2})[(cl-i)%3+1]
                local c = ({8,9,2})[(cl-i)%3+1]
                --{8,9,2}{11,8,12}
                local x_center = 64
                local y_center = 64
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
            spr_r(1,40,40,4*t%360,1,1)
         end},
        {"WOWZA IM SO COOL INIT BRUV", function() end}
    }
end

function intro_update()
    t+=1
    if intro_scene_state==0 then
        fade_in = max(fade_in-0.5,0)
        if fade_in==0 then intro_scene_state=1 end
    elseif intro_scene_state==1 then
        if btnp(4) then
            intro_scene_state=2
        end
    elseif intro_scene_state==2 then
        fade_in = min(fade_in+0.5,18)
        if fade_in==18 then
            current_intro_screen+=1
            if current_intro_screen > #intro_scenes then
                level_init()
            else
                intro_scene_state=0
            end
        end
    end
end

function intro_draw()
    cls(1)
    fade(fade_in)

    clip(14,20,100,50)
    rrectfill(14,20,100,50,3,7)
    draw_background()
    intro_scenes[current_intro_screen][2]()
    clip()
    para_print(intro_scenes[current_intro_screen][1],76,6)
    --print(intro_scenes[current_intro_screen][1],24,70,6)
    --print("❎",x+2,y-6)



    -- fade(0)
    -- draw_foreground()
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