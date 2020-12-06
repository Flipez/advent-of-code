groups = File.read('./input').split("\n\n")

answers_single = 0
answers_all = 0

groups.each do |group|
  answers_single += group.split("\n").join.chars.uniq.count
  answers_all += group.split("\n").map(&:chars).inject(:&).to_a.count
end

p answers_single
p answers_all