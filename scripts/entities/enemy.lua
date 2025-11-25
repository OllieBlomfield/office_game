ENEMY_SPEED = 0.15

function add_enemy(x,y, start_dir)
    add(entities,{
        x=x,
        y=y,
        w=6,
        h=8,
        dx=0,
        dy=0,
        state=0,
        dir=start_dir,
        update=enemy_update,
        draw=enemy_draw,
    })
end

function enemy_update(enemy)
    damage_plr_on_hit(enemy)

    enemy.dx=ENEMY_SPEED*enemy.dir

    enemy.dy = max(enemy.dy - NORMAL_GRAVITY, -MAX_Y_VELOCITY)

    if enemy.dx!=0 and t%50>45 then
        add_dust(enemy.x+4,enemy.y+7)
    end

    if collide_map(enemy, "down", 1) then 
        enemy.dy = 0
        enemy.y -= ((enemy.y+enemy.h+1)%8)-1
    end

    enemy.x+=enemy.dir*4
    if not collide_map(enemy,"down",1) then
        enemy.dir*=-1
        enemy.x+=enemy.dir*4
    else
        enemy.x-=enemy.dir*4
    end

    if collide_map(enemy,"right",0) then
      enemy.dir=-1
    end
    if collide_map(enemy,"left",0) then
      enemy.dir=1
    end
    enemy.x+=enemy.dx
    enemy.y-=enemy.dy
end

function enemy_draw(enemy)
    sp = ({17,18,19,18})[1+(t%180\45)]
    spr(sp,enemy.x,enemy.y,0.875,1,enemy.dir<0)
end


