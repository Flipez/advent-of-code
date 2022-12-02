input = IO.open("./input").lines()

// A,X: Rock 1
// B,Y: Paper 2
// C,Z: Scissors 3

p1_scores = {
  "AX": 4,
  "AY": 8,
  "AZ": 3,
  "BX": 1,
  "BY": 5,
  "BZ": 9,
  "CX": 7,
  "CY": 2,
  "CZ": 6,
}

// A: Rock 1
// B: Paper 2
// C: Scissors 3

// X: Lose  0
// Y: Draw 3
// Z: Win 6

p2_scores = {
  "AX": 3,
  "AY": 4,
  "AZ": 8,
  "BX": 1,
  "BY": 5,
  "BZ": 9,
  "CX": 2,
  "CY": 6,
  "CZ": 7,
}

def calculate_score(scores)
  score = 0

  foreach game in input
    score = score + scores[game.replace(" ", "")]
  end

  score
end

puts("Part 1: %d".format(calculate_score(p1_scores)))
puts("Part 2: %d".format(calculate_score(p2_scores)))