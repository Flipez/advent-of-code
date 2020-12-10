numbers = File.readlines("./input").map(&:to_i).sort

numbers.unshift(0)
numbers.push(numbers.last+3)
one = 0
three = 0
variants = {}


numbers[1..numbers.size].sort.each_with_index do |current_number, index|
  case (current_number - numbers[index])
  when 1
    one += 1
  when 3
    three += 1
  end
end

p one * three


def outlets(numbers, current, variants)
  return 1 if current == numbers.last

  unless variants[current]

    one = current + 1
    two = current + 2
    three = current + 3
    lines = []

    lines << outlets(numbers, one, variants)   if numbers.include?(one)
    lines << outlets(numbers, two, variants)   if numbers.include?(two)
    lines << outlets(numbers, three, variants) if numbers.include?(three)

    variants[current] = lines.sum
  end

  return variants[current]
end

p outlets(numbers, 0, variants)