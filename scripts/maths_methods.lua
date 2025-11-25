function ease_in_quadratic(t)
    return t*t
end

function ease_out_overshoot(t)
    local y = t-1
    return 1 - 2.7*y*y*y + 1.7*y*y
end

function lerp(a,b,time,t_func)
    t_func = t_func or ease_in_quadratic
    time = t_func(time)
    return a+time*(b-a)
end

