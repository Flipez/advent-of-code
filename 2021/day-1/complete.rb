input = File.readlines("./input").map(&:to_i)

increase = 0

input.each_with_index do |n, i|
  if n > input[i-1].to_i
    increase += 1
  end
end

p increase

increase =0
input.each_with_index do |n, i|
  sum = n + input[i+1].to_i + input[i+2].to_i
  sum2 = input[i+1].to_i + input[i+2].to_i + input[i+3].to_i

  if sum2 > sum
    increase += 1
  end
end

p increase