function add_dust(x,y)
    add(particles,{
        x=x,
        y=y,
        l=rnd(20)+20,
        c=6,
        update=dust_update,
        draw=dust_draw
    })
end

function dust_update(p)
    p.y-=rnd(0.5)
end

function dust_draw(p)
    --pset(p.x,p.y,6)
    if p.l<7 then
        pset(p.x,p.y,p.c)
    else
        --rectfill(p.x,p.y,p.x+1,p.y+1,p.c)
        circfill(p.x,p.y,p.l/17,p.c)
    end
end