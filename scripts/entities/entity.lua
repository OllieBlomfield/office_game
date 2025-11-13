--general entity helper methods
function damage_plr_on_hit(e)
    if coll(plr,e) and plr.state!=2 then
        plr_damage()
    end
end

function entity_update()
    for e in all(entities) do e.update(e) end
end