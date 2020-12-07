rules = File.readlines('./input')

bags = {}

solution_bags = []

rules.each do |rule|
  color, contains = rule.match(/\A(.*)\sbags\scontain\s(.*)/).captures
  bags[color] = {}

  next if contains == 'no other bags.'

  contains.split(',').each do |inner_contains|
    inner_contains.delete!('.')
    amount, inner_color = inner_contains.match(/\A\s?(\d+)\s(.*)\sbags?/).captures
    bags[color][inner_color] = amount.to_i
  end
end

relevant = bags.select do |color, contains|
  contains.keys.include? 'shiny gold'
end

def bags_with(color, bags, solution_bags)
  rel = bags.select do |_, contains|
    contains.keys.include? color
  end
  if rel.any?
    rel.map do |c, n|
      solution_bags << c
      bags_with(c, bags, solution_bags)
    end
  end
end

def bags_count(color, bags)
  count = 1
  bags[color].each do |rule|
    if rule.any?
      count += rule[1] * bags_count(rule[0], bags)
    end
  end
  count
end

bags_with('shiny gold', bags, solution_bags)

p solution_bags.uniq.count
p bags_count('shiny gold', bags) -1