lines = File.readlines('./input')

@global_direction = 90

@directions = {
  N: 0,
  E: 90,
  S: 180,
  W: 270
}

@x = 0
@y = 0



def move(direction, value)
  case direction
  when 0 then @y -= value
  when 90 then @x += value
  when 180 then @y += value
  when 270 then @x -= value
  end
end

def rotate(amount)
  @global_direction = (@global_direction + amount) % 360
end

lines.each do |line|
  instruction, value = line.match(/(\w)(\d+)/).captures
  value = value.to_i
  case instruction
  when 'F' then move(@global_direction, value)
  when 'N', 'S', 'E', 'W' then move(@directions[instruction.to_sym], value)
  when 'L' then rotate(-value)
  when 'R' then rotate(value)
  end
end

p @x.abs + @y.abs