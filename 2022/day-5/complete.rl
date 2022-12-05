input = IO.open("./input").lines()

instructions = []
foreach line in input
  if (line[0] == "m")
    instructions.yoink(line)
  end
end

// Test Input Stack
// stacks = [
//   ["Z", "N"],
//   ["M", "C", "D"],
//   ["P"]
// ]

stacks = [
  ["R", "G", "H", "Q", "S", "B", "T", "N"],
  ["H", "S", "F", "D", "P", "Z", "J"],
  ["Z", "H", "V"],
  ["M", "Z", "J", "F", "G", "H"],
  ["T", "Z", "C", "D", "L", "M", "S", "R"],
  ["M", "T", "W", "V", "H", "Z", "J"],
  ["T", "F", "P", "L", "Z"],
  ["Q", "V", "W", "S"],
  ["W", "H", "L", "M", "T", "D", "N", "C"]
]

foreach instruction in instructions
  amount = instruction.split("from")[0].split("move")[-1].strip().plz_i()
  from = instruction.split("to")[0].split("from")[-1].strip().plz_i()
  to = instruction.split("to")[1].strip().plz_i()

  temp_stack = []

  foreach i in amount
    temp_stack.yoink(stacks[from - 1].yeet())
  end
  temp_stack.reverse()
  foreach item in temp_stack
    stacks[to - 1].yoink(item)
  end

end

result = ""
foreach stack in stacks
  result = result + stack[-1]
end
puts(result)

nil