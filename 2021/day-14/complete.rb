input = File.readlines("./input", chomp: true)

steps = {}
input[2..-1].each do |step|
  steps[step.split(" -> ")[0]] = step.split(" -> ")[1]
end

template = input[0]

#10.times do
#  new_template = ""
#  template.chars.each_cons(2).each do |pair|
#    new_template += pair[0] + steps[pair.join]
#  end
#  template = new_template + template[-1]
#end
#
#count = template.chars.tally
#p count.values.max - count.values.min
#

counts = Hash.new(0)
template.chars.each_cons(2) do |pair|
  counts[pair.join] += 1
end
p template
40.times do
    counts_old = counts.dup
    counts = Hash.new(0)
    counts_old.each do |pair, count|
        new_char = steps[pair]
        counts[pair[0] + new_char] += count
        counts[new_char + pair[1]] += count
    end
end

sums = Hash.new(0)
counts.each do |pair, count|
  sums[pair[0]] += count
end
sums[template[-1]] += 1
p sums.values.max - sums.values.min