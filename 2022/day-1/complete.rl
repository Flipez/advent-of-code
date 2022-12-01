input = IO.open("./input").lines()

count = 0
elves = {0: 0}

foreach item in input
  if (item == "")
    count = count + 1
    elves[count] = 0
  end

  elves[count] = elves[count] + item.plz_i()
end

puts("Part 1: %d".format(elves.values().sort()[-1]))

sum = 0
foreach item in elves.values().sort()[-3:]
  sum = sum + item
end

puts("Part 2: %d".format(sum))

