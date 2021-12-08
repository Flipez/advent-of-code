input = File.readlines("./input_test")

## part 1

count = 0
input.each do |line|
  output = []
  line.split(" | ")[1].split(" ").each do |digits|
    case digits.size
    when 2, 4, 3, 7
      count +=1
    end
  end
end

p count

## part 2

numbers = [
  'abcefg', # 0
  'cf', # 1
  'acdeg', # 2
  'acdfg', # 3
  'bcdf', # 4
  'abdfg', # 5
  'abdefg', # 6
  'acf', # 7
  'abcdefg', # 8
  'abcdfg' # 9
]
reference = 'abcdefg'

# Part 2
sum = 0
input.each do |line|
  split = line.split(" | ")
  input = split[0].split
  output = split[1].split

  reference_permutations = reference.chars.permutation

  correct = reference_permutations.find do |perm|
      digit = perm.join
      input.map do |output|
        p output
        output.tr(digit, reference).chars.sort.join
      end.sort == numbers.sort
  end.join

  mapping = numbers.map do |number|
    number.tr(reference, correct).chars.sort.join
  end

  result = output.map do |digit|
    mapping.index(digit.chars.sort.join)
  end.join
  sum += result.to_i
end
p sum