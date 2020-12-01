ar = File.readlines("../input").map(&:to_i)

ar.combination(2).map { |c| p c.reduce(&:*) if c.sum == 2020 }
ar.combination(3).map { |c| p c.reduce(&:*) if c.sum == 2020 }