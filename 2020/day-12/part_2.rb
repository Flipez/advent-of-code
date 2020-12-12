lines = File.readlines('./input')

@x = 0
@y = 0
@way_x = 10
@way_y = -1

def move(direction, value)
  case direction
  when 0 then @way_y -= value
  when 90 then @way_x += value
  when 180 then @way_y += value
  when 270 then @way_x -= value
  end
end

def rotate(amount)
  (amount % 360 / 90).times do
    @way_x, @way_y = @way_y, @way_x
    @way_x = -@way_x
  end
end

lines.each do |line|
  instruction, value = line.match(/(\w)(\d+)/).captures
  value = value.to_i
  case instruction
  when 'F' then
    @x += @way_x * value
    @y += @way_y * value
  when 'N' then move(0, value)
  when 'E' then move(90, value)
  when 'S' then move(180, value)
  when 'W' then move(270, value)
  when 'L' then rotate(-value)
  when 'R' then rotate(value)
  end
end

p @x.abs + @y.abs