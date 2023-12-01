input = File.readlines("./input")

sum = 0

input.each do |line|
  num = line.scan(/\d/).join('')
  val = "#{num[0]}#{num[-1]}".to_i
  sum += val
end
puts sum


sum = 0
idx = {"one" => 1,
       "two" => 2,
       "three" => 3,
       "four" => 4,
       "five" => 5,
       "six" => 6,
       "seven" => 7,
       "eight" => 8,
       "nine" => 9}
input.each do |line|
  nums = line.scan(/(?=(one|two|three|four|five|six|seven|eight|nine|\d))/).flatten
  val = "#{idx[nums[0]] || nums[0]}#{idx[nums[-1]] || nums[-1]}".to_i
  sum += val
end

puts sum
