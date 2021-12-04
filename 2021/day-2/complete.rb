input = File.readlines("./input")

depth = 0
hor = 0
aim = 0

input.each do |line|
  command = line.split(' ')[0]
  value = line.split(' ')[1].to_i

  case command
  when 'forward'
    hor += value
    depth = depth + (value * aim)
  when 'down'
    aim += value
  when 'up'
    aim -= value
  end
end


p hor * depth