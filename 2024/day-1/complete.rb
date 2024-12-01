input = File.readlines("./input")

l = []
r = []
sum = 0
sum2 = 0

input.each do |line|
  p line.strip
  a, b = line.split(" ")
  l << a.to_i
  r << b.to_i
end


l_sort = l.sort
r_sort = r.sort

l_sort.size.times do
  sum += (l_sort.shift - r_sort.shift).abs
end

p "Part 1: #{sum}"

l.each do |number|
  sum2 += (number * r.count(number))
end

p "Part 2: #{sum2}"