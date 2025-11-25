function set_pal()
  fillp()
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
  for e in all(entities) do
    rect(e.x,e.y,e.x+e.w,e.y+e.h,11)
  end
  for o in all(objects) do
    rect(o.x,o.y,o.x+o.w,o.y+o.h,11)
  end
end

function center_print(txt,y,c,highlight, border)
  border = false or border
  highlight = highlight or ""
  local text_width = #txt * 4
  local x = (128 - text_width) / 2
  if border then rrectfill(x-1,y-1,text_width+1,7,1,6) end
  print(highlight..txt, x, y, c)
end