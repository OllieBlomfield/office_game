function play_sfx(n,time)
    time = time or 0
    if sfx_time <= 0 then 
        sfx_time+=time
        sfx(n) 
    end     
end