input = File.readlines("./input")

gamma = ""
epsilon = ""

12.times do |i|
  ones = 0
  zeros = 0
  input.each do |line|
    if line[i] == "1"
      ones = ones + 1
    else
      zeros = zeros + 1
    end
  end

  p ones
  p zeros

  if ones > zeros
    gamma += "1"
    epsilon += "0"
  else
    gamma += "0"
    epsilon += "1"
  end
end

p gamma
p epsilon

p gamma.to_i(2) * epsilon.to_i(2)
