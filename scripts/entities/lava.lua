function add_lava(x,y)
    add(entities,{
        x=x,
        y=y,
        h=8,
        w=8,
        lava_particles = {},
        update=lava_update,
        draw=lava_draw,
        box={x=x,y=y+2,w=8,h=6}
    })
end

function lava_update(e)
    damage_plr_on_hit(e.box)
    if rnd(10)>=9 then
        add(particles, {
                x=rnd(8)+e.x,
                y=rnd(5)+e.y+3,
                vx=rnd({-1,1})*rnd(0.2),
                vy=rnd(0.3),
                s=2,
                l=45+rnd(20),
                c=rnd({8,9,1}),
                update=lava_particle_update,
                draw=lava_particle_draw,
            })
    end
    --add_dust(e.x+rnd(5),e.y+rnd(4))
end

function lava_draw(e)
    --spr(23,e.x,e.y)
    for i=0,7 do
        -- pset(e.x+i,e.y-2*sin((t+e.x+i)/40),9)
        local y = 2*sin((t+e.x+i)/80) + sin((t/4+e.x+i)/20)
        pset(e.x+i,e.y+y,10)
        line(e.x+i,e.y+1+y,e.x+i,e.y+8,9)
        line(e.x+i,e.y+4+y*0.5,e.x+i,e.y+8,8)
        line(e.x+i,e.y+7+y*0.3,e.x+i,e.y+8,2)
    end
end

function lava_particle_update(p)
    --p.vy-=0.01
    if p.l<4 then p.s=1 end
    p.x+=p.vx
    p.y-=p.vy
end

function lava_particle_draw(p)
    rrect(p.x,p.y,p.s,p.s,0,p.c)
end