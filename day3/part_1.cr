wires = File.read("input").split("\n")

wire_1 = [[0,0]]
wire_2 = [[0,0]]

wires[0].split(",").each do |instruction|
  direction = instruction[0]
  lenght = instruction[1..-1].to_i
  x = wire_1[-1][0]
  y = wire_1[-1][1]
  case direction
  when 'R'
    lenght.times { |i| wire_1 << [x + (i + 1), y]}
  when 'L'
    lenght.times { |i| wire_1 << [x - (i + 1), y]}
  when 'U'
    lenght.times { |i| wire_1 << [x, y + (i + 1)]}
  when 'D'
    lenght.times { |i| wire_1 << [x, y - (i + 1)]}
  end
end

wires[1].split(",").each do |instruction|
  direction = instruction[0]
  lenght = instruction[1..-1].to_i
  x = wire_2[-1][0]
  y = wire_2[-1][1]
  case direction
  when 'R'
    lenght.times { |i| wire_2 << [x + (i + 1), y]}
  when 'L'
    lenght.times { |i| wire_2 << [x - (i + 1), y]}
  when 'U'
    lenght.times { |i| wire_2 << [x, y + (i + 1)]}
  when 'D'
    lenght.times { |i| wire_2 << [x, y - (i + 1)]}
  end
end

wire_1.delete([0,0])
wire_2.delete([0,0])

intersections = (wire_1 & wire_2)

costs = intersections.map do |point|
  (0-point[0]).abs + (0-point[1]).abs
end

p costs.sort.first