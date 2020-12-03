lines = File.readlines('./input').map(&:chomp)

width = lines.first.size - 1

trees = 0
current_pos = 0

lines.each do |current_line|
  current_pos = (current_pos - width) - 1 if current_pos > width
  char = current_line[current_pos]
  trees = trees + 1 if char == '#'
  current_pos += 3
end

p trees