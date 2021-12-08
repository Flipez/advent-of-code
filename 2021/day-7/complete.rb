input = File.read("./input").split(",").map(&:to_i)
#input = File.readlines("./input")

old_sum = nil
sum = 0
(input.min..input.max).each do |height|
  sum = 0
  input.each do |crab|
    step = 1
    sum += (crab - height).abs.times.map do |i|
      i + step
    end.sum
  end
  if old_sum == nil || old_sum > sum
    old_sum = sum
  end
end

p old_sum