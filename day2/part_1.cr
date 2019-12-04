intcodes = File.read("input").split(",").map do |intcode|
  intcode.to_i
end
current_position = 0
current_opcode = 0

intcodes[1] = 12
intcodes[2] = 2

until current_opcode == 99
  current_opcode = intcodes[current_position].to_i
  a = intcodes[current_position + 1].to_i
  b = intcodes[current_position + 2].to_i
  target = intcodes[current_position + 3].to_i  

  case current_opcode
  when 1
    intcodes[target] = intcodes[a].to_i + intcodes[b].to_i
  when 2
    intcodes[target] = intcodes[a].to_i * intcodes[b].to_i
  when 99
    break
  end

  current_position += 4
end

puts intcodes[0]
