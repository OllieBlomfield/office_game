function save_game(n)
    dset(0,1)
    dset(1,n)
    dset(2,max_level)
    dset(3,num_deaths)
    dset(4, game_timer)
end

function load_game()
    max_level = min(dget(2),15)
    lvl = min(dget(1),15)
    --lvl = 12
    num_deaths = dget(3)
    game_timer = dget(4)
    new_game = false
end

function reset_game_save()
    dset(0,0)
end

function reset_game()
    dset(0,0)
    --_init()
end

function set_default_globals()
    max_level = 1
    lvl = 1
    new_game = true
    num_deaths = 0
    game_timer = 0
end

--0 new game? (0 for new game, otherwise not)
--1 current level
--2 max level achieved
--3 current number of deaths
--4 time taken so far