input = File.read("./input_test")
sum = 0
muls = input.scan(/mul\((\d{1,3}),(\d{1,3})\)/)

muls.each do |mul|
  sum += mul[0].to_i * mul[1].to_i
end

puts "Part 1: #{sum}"


### part 2

input = File.read("./input_test2")
instructions = input.scan(/(mul\((\d{1,3}),(\d{1,3})\))|(don't\(\))|(do\(\))/)
sum2 = 0

skip = false
instructions.each do |instruction|
  skip = true if instruction[3]
  skip = false if instruction[4]

  unless skip
    sum2 += instruction[1].to_i * instruction[2].to_i
  end
end

puts "Part 2: #{sum2}"