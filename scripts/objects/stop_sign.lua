function add_stop_sign(x,y)
    add(objects,{
        x=x+3,
        y=y+3,
        w=1,
        h=1,
        func=stop_sign
    })
end

function stop_sign()
    if plr.no_stop_delay <= 0 then
        plr.dx = 0
        plr.state = 0
    end
end