input = File.readlines("./input", chomp: true)
map = input.map {|x| x.chomp.chars.map{|c|c.to_i}}

def flash(map, y, x)
  flashed = 1
  (([y-1, 0].max)..([y+1, map.size-1].min)).each do |yp|
    (([x-1, 0].max)..([x+1, map[y].size-1].min)).each do |xp|
      map[yp][xp] += 1
      if map[yp][xp] == 10
        flashed += flash(map, yp, xp)
      end
    end
  end
  flashed
end

flashed = 0
100.times do
  map.size.times do |y|
    map[y].size.times do |x|
      map[y][x] += 1
      flashed += flash(map, y, x) if map[y][x] == 10
    end
  end
  map.size.times do |y|
    map[y].size.times do |x|
      map[y][x] = 0 if map[y][x] > 9
    end
  end
end

p flashed


0.upto(Float::INFINITY) do |i|
  flashed = 0
  map.size.times do |y|
    map[y].size.times do |x|
      map[y][x] += 1
      flashed += flash(map, y, x) if map[y][x] == 10
    end
  end
  map.size.times do |y|
    map[y].size.times do |x|
      map[y][x] = 0 if map[y][x] > 9
    end
  end
  if flashed == map.size * map[0].size
    p i + 1 + 100
    exit
  end
end