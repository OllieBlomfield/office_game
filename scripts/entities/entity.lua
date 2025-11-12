--general entity helper methods
function damage_plr_on_hit(e)
    if coll(plr,e) and plr.state!=2 then
        plr_damage()
    end
end