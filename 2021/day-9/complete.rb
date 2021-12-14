input = File.readlines("./input")
@map = input.map {|x| x.chomp.chars.map{|c|c.to_i}}
@w = @map[0].length
@h = @map.length

def point(x,y)
  return 10 if y >= @h || x >= @w
  return 10 if x < 0 || y < 0
  return @map[x][y]
end

sum = 0
(0...@h).each do |x|
    (0...@w).each do |y|
        low_point =
            point(x,y) < point(x+1,y) &&
            point(x,y) < point(x-1,y) &&
            point(x,y) < point(x,y+1) &&
            point(x,y) < point(x,y-1)
        sum += point(x,y) + 1 if low_point
    end
end
p sum

@visited = {}
@basins = []
def walk(x,y, basin)
  return unless point(x,y) < 9
  return if @visited[[x,y]]
  @visited[[x,y]] = basin
  basin[:size] += 1
  walk(x-1,y, basin)
  walk(x+1,y, basin)
  walk(x,y-1, basin)
  walk(x,y+1, basin)
end

def fill(x,y)
  basin = {size:0}
  @basins << basin
  walk(x,y, basin)
end

(0...@h).each do |i|
    (0...@w).each do |j|
        fill(i,j)
    end
end
p @basins.map { |b| b[:size] }.sort.last(3)
p @basins.map { |b| b[:size] }.sort.last(3).inject(&:*)