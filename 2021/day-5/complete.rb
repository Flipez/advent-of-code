#input = File.readlines("./input_test")
input = File.readlines("./input")

map = {}
grid = []

input.each do |line|
  one, two = line.split(" -> ")
  x1, y1 = one.split(",")
  x2, y2 = two.split(",")
  y2 = y2.chomp

  x1 = x1.to_i
  x2 = x2.to_i
  y1 = y1.to_i
  y2 = y2.to_i

  mod = 1 # -1

  if y1==y2
    if x1 > x2
      mod = -1
    end

    (0..((x1-x2).abs)).each do |off|
      point = "#{x1 + (mod * off)}x#{y1}"
      map[point] = map[point].to_i + 1
    end
  elsif x1==x2
    if y1 > y2
      mod = -1
    end

    (0..((y1-y2).abs)).each do |off|
      point = "#{x1}x#{y1 + (mod * off)}"
      map[point] = map[point].to_i + 1
    end
  elsif
    mod_x = (x1 > x2) ? -1 : 1
    mod_y = (y1 > y2) ? -1 : 1

    (0..((x1-x2).abs)).each do |off_x|
      point = "#{x1 + (mod_x * off_x)}x#{y1 + (mod_y * off_x)}"
      map[point] = map[point].to_i + 1
    end

  end


end

p map.select{|k,v | v >= 2}.count