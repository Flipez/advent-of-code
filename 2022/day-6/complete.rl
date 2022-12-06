input = IO.open("./input").lines()

def parse_message(line, size)
  foreach i, char in line
    if (i >= size)
      if (line[i-size:i].split("").uniq().size() == size)
        return(i)
      end
    end
  end
end

foreach i, line in input
  puts("--- Line %d ---".format(i))
  puts("Part 1: %d".format(parse_message(line, 4)))
  puts("Part 2: %d".format(parse_message(line, 14)))
end

nil