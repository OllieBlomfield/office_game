current_song = -1
function play_sfx(n,time)
    time = time or 0
    if sfx_time <= 0 then 
        sfx_time+=time
        sfx(n) 
    end     
end

function play_song(n, fade_len)
    fade_len = fade_len or 0
    if current_song!=n then
        music(n,fade_len,3)
        current_song=n
    end
end
