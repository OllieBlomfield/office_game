function add_pop(x,y)
    for i=1,60 do
        --al = al or 0
        --v = v or 0
        add(particles, {
            x=x,
            y=y,
            vx=rnd(1.2)-0.6,
            vy=rnd(1.2),
            c=rnd({15,15,1,1,13,8}),
            l=rnd(50),
            update=pop_update,
            draw=pop_draw
        })
    end
end

function pop_update(p)
    p.vy-=0.03
    p.y-=p.vy
    p.x+=p.vx
end

function pop_draw(p)
    --pset(p.x,p.y,p.c)
    rectfill(p.x,p.y,p.x+1,p.y+1,p.c)
end