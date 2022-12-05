input = IO.open("./input").lines()

def array_in_array(a, b)
  result = true

  foreach item in a
    if (b.index(item) == -1)
      result = false
    end
  end

  result
end

def array_overlap_array(a, b)
  result = false

  foreach item in a
    if (b.index(item) != -1)
      result = true
    end
  end

  result
end

def elve_to_range(elve)
  range = [elve.split("-")[0].plz_i()]
  while (range[-1] < elve.split("-")[1].plz_i())
    range.yoink(range[-1] + 1)
  end

  range
end

include_sum = 0
overlap_sum = 0

foreach pair in input
  elve_a = pair.split(",")[0]
  elve_b = pair.split(",")[1]

  range_a = elve_to_range(elve_a)
  range_b = elve_to_range(elve_b)

  a_in_b = array_in_array(range_a, range_b)
  b_in_a = array_in_array(range_b, range_a)

  if (a_in_b || b_in_a)
    include_sum = include_sum + 1
  end

  a_overlap_b = array_overlap_array(range_a, range_b)
  b_overlap_a = array_overlap_array(range_b, range_a)

  if (a_overlap_b || b_overlap_a)
    overlap_sum = overlap_sum + 1
  end
end

puts("Part 1: %d".format(include_sum))
puts("Part 2: %d".format(overlap_sum))