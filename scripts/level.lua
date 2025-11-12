levels = {}
levels[1] = {{16,112}, {110,8}, function() end}
levels[2] = {{16,112}, {16,8}}
levels[3] = {{16,112}, {104,16}}
levels[4] = {{9,112}, {110,8}}
levels[5] = {{111,112}, {110,8}}

function reset_level() --fix mx and my
    level_state = 0 --0 intro, 1 playing, 2 clear
    mx = (lvl-1)*16
    my = (lvl-1)\16
    current_lvl=levels[lvl]
    objects = {}
    entities = {}
    particles = {}
    plr_init(current_lvl[1][1],current_lvl[1][2])
    level_has_key = false
    key_collected = false
    level_anim_start_time = t
    level_anim_time = 0
    scan_map()
    if current_lvl[3] then
        current_lvl[3]()
    end
    --add_enemy(40,40)
    add_exit(current_lvl[2][1],current_lvl[2][2])
end

function next_level()
    lvl+=1
    transition_out_level()
end

function transition_out_level()
    level_state = 2
    level_anim_start_time = t + 40
end
