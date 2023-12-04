input = File.readlines("./input")

points = 0
card_count = {}

input.each do |line|
  card, nums = line.strip.split(":")

  card = card.split[1].to_i
  numbers, winning_numbers = nums.split("|")
  numbers = numbers.strip.split.map(&:to_i)
  winning_numbers = winning_numbers.strip.split.map(&:to_i)

  card_count[card] = card_count[card].to_i + 1

  matches = []
  numbers.each do |number|
    if winning_numbers.include? number
      ## part 1
      matches << number
    end
  end

  matches.each_with_index do |number, idx|
    card_count[card + idx + 1 ] = card_count[card + idx + 1].to_i + card_count[card]
  end

  if matches.size > 0
    points += (2 ** (matches.size - 1))
  end 


end

p points
p card_count
p card_count.values.inject(:+)

