function set_pal()
  fillp()
  pal()
  poke( 0x5f2e, 1)
  pal(0,1,1)
  pal(1,129,1)
  pal(2,136,1)
  pal(5,134,1)
  --pal(10,143,1)
  pal(11,139,1)
  pal(14,143,1)
  palt(4, true)
  palt(0, false)
end

function draw_foreground()
  rectfill(0,0,128,4,6)
  for i=0,2 do
    rectfill(1+(i*4),1,3+(i*4),3,({8,9,11})[i+1])
  end
end

function draw_background()
  for i=-2,10 do
    local offset = 0
    if (i\2)%2==0 then
      rect(
      32+64*(i%2)+offset,
      32*(i\2)+offset,
      63+64*(i%2)+offset,
      31+32*(i\2)+offset,
      6)
    else
      rect(
      64*(i%2)+offset,
      32*(i\2)+offset,
      31+64*(i%2)+offset,
      31+32*(i\2)+offset,
      6)
    end
  end
end

function draw_debug()
  print(#particles,10,10,1)
  print(mx)
  print(my)
  print(lvl)
  print(sfx_time)
  print(plr.coy_time)
  for e in all(entities) do
    if e.box then
      rrect(e.box.x,e.box.y,e.box.w,e.box.h)
    else
      rect(e.x,e.y,e.x+e.w,e.y+e.h,11)
    end
  end
  for o in all(objects) do
    rect(o.x,o.y,o.x+o.w,o.y+o.h,11)
  end
end

function draw_curve(a,b,c,size,col)
  local scale_factor = 1/size
  for i=0,size do
    local t = i*scale_factor
    local x = (1-t)*(1-t)*a[1] + 2*(1-t)*t*b[1] + t*t*c[1]
    local y = (1-t)*(1-t)*a[2] + 2*(1-t)*t*b[2] + t*t*c[2]
    pset(x,y,col)
  end
end

function spr_r(s,x,y,a,w,h)
 sw=(w or 1)*8
 sh=(h or 1)*8
 sx=(s%8)*8
 sy=flr(s/8)*8
 x0=flr(0.5*sw)
 y0=flr(0.5*sh)
 a=a/360
 sa=sin(a)
 ca=cos(a)
 for ix=0,sw-1 do
  for iy=0,sh-1 do
   dx=ix-x0
   dy=iy-y0
   xx=flr(dx*ca-dy*sa+x0)
   yy=flr(dx*sa+dy*ca+y0)
   if (xx>=0 and xx<sw and yy>=0 and yy<=sh) then
    local col = sget(sx+xx,sy+yy)
    if col!=4 then
      pset(x+ix,y+iy,col)
    end
   end
  end
 end
end

function para_print(txt,y,c,highlight,border)
  local line_length = 20
  for i=0,#txt\line_length do
    center_print(sub(txt,1+20*i,20*(i+1)),y+i*6,c,highlight,border)
  end
end

function center_print(txt,y,c,highlight, border)
  border = false or border
  highlight = highlight or ""
  local text_width = #txt * 4
  local x = (128 - text_width) / 2
  if border then rrectfill(x-1,y-1,text_width+1,7,1,6) end
  return print(highlight..txt, x, y, c)
end