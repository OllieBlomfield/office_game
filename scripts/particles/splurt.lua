function add_splurt(x,y)
    for i=0,5 do
        add(particles,{
            x=x,
            y=y,
            vx=rnd({-0.1,0.1}),
            vy=-rnd(1),
            l=rnd(8)+10,
            update=splurt_update,
            draw=splurt_draw
        })
    end
end

function splurt_update(p)
    p.x+=p.vx
    p.y+=p.vy
end

function splurt_draw(p)
    pset(p.x,p.y,8)
end