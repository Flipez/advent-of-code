
input = File.readlines("./input")

mapped = input.map{|line| line.strip.split("")}

def is_surrounded(mapped, row, pos, number_end_pos)
  for cur_row in (row-1..row+1)
    if cur_row < 0 || cur_row == mapped.length
      next
    end

    for cur_pos in (pos-1..number_end_pos+1)
      if cur_pos < 0 || cur_pos == mapped[cur_row].length
        next
      end

      if /[^0-9.]/.match(mapped[cur_row][cur_pos])
        return true
      end
    end
  end
  false
end

def get_neighboards(m, row, col)
  res = []
  ind = []
  for x in (row - 1..row + 1)
    next if x < 0 || x == m.length
    for y in (col - 1..col + 1)
      if (/\d/.match m[x][y])
        ind.push [x, y]
      end

    end
  end

  visited = []

  for i in ind
    next if visited.include?(i)
    visited.push i
    number = m[i[0]][i[1]]

    #to_left
    h = i[1] - 1
    while /\d/.match m[i[0]][h] and !visited.include?([i[0], h])
      number = m[i[0]][h] + number
      visited.push [i[0], h]
      h -= 1
    end

    #to_right
    h = i[1] + 1
    while /\d/.match m[i[0]][h] and !visited.include?([i[0], h])
      number += m[i[0]][h]
      visited.push [i[0], h]
      h += 1
    end
    res.push number.to_i
  end

  res
end

sum = 0

row = 0
while row < mapped.length
  pos = 0
  while pos < mapped[row].length
    if /\d/.match(mapped[row][pos])
      number_end_pos = pos
      while /\d/.match(mapped[row][number_end_pos + 1])
        number_end_pos += 1
      end

      number = mapped[row][pos..number_end_pos].join.to_i

      sum += number if is_surrounded(mapped, row, pos, number_end_pos)

      # forward current position to number ending
      pos = number_end_pos
    end

    # forward to end of number + 1
    pos +=1
  end

  row += 1
end

p sum



###
# Part 2

sum = 0
row = 0
while row < mapped.length
  pos = 0
  while pos < mapped[row].length
    if /\*/.match(mapped[row][pos])
      neighbors = get_neighboards(mapped, row, pos)
      if neighbors.size == 2
        sum += neighbors[0] * neighbors[1]
      end
    end
    pos +=1
  end
  row += 1
end

p sum