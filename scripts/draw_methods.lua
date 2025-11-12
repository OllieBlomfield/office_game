function set_pal()
  fillp()
  pal(1,129,1)
  pal(2,136,1)
  pal(5,134,1)
  pal(11,139,1)
  pal(14,135,1)
  palt(4, true)
  palt(0, false)
end

function draw_foreground()
  rectfill(0,0,128,4,6)
  for i=0,2 do
    rectfill(1+(i*4),1,3+(i*4),3,({8,10,11})[i+1])
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