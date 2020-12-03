lines = File.readlines('./input').map(&:chomp)

width = lines.first.size - 1

sums = []

# right, down
slopes = [
  [1,1],
  [3,1],
  [5,1],
  [7,1],
  [1,2],
]

slopes.each do |slope|
  trees = 0
  current_pos = 0
  lines.each_slice(slope[1]) do |slice|
    current_line = slice.first
    current_pos = (current_pos - width) -1 if current_pos > width
    char = current_line[current_pos]
    trees = trees + 1 if char == '#'
    current_pos += slope[0]

  end
  sums << trees
end

p sums.reduce(&:*)