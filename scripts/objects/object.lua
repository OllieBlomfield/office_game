function scan_map()
    for sx=0,15 do
        for sy=0,15 do
            s = mget(sx+mx,sy+my)
            if s==4 then
                add_stop_sign(sx*8,sy*8)
            elseif s==5 then
                add_spike(sx*8,sy*8)
            elseif s==17 or s==18 then
                add_enemy(sx*8,sy*8,s==17 and 1 or -1)
            elseif s==20 then
                add_ghost(sx*8,sy*8)
            elseif s==64 then
                add_key(sx*8,sy*8)
            end
        end
    end
end