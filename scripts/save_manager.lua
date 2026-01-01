function save_game(n)
    dset(0,1)
    dset(1,n)
    dset(2,max_level)
end

function load_game()
    max_level = min(dget(2),15)
    lvl = min(dget(1),15)
    --lvl = 15
    new_game = false
end

function reset_game_save()
    dset(0,0)
end

--0 new game? (0 for new game, otherwise not)
--1 current level
--2 max level achieved