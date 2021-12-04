input = File.readlines("./input")

oxygens = input.dup
co2 = input.dup

final_o = 0
final_c = 0

12.times do |i|
  zeros = 0
  ones = 0
  oxygens.each do |line|
    if line[i] == "1"
      ones = ones + 1
    else
      zeros = zeros + 1
    end
  end
  if zeros > ones
    oxygens = oxygens.select {|line| line[i] == "0"}
  else
    oxygens = oxygens.select {|line| line[i] == "1"}
  end

  final_o = oxygens.first if oxygens.size == 1
end


12.times do |i|
  zeros = 0
  ones = 0
  co2.each do |line|
      if line[i] == "1"
        ones = ones + 1
      else
        zeros = zeros + 1
      end
  end
  if zeros > ones
    co2 = co2.select {|line| line[i] == "1"}
  else
    co2 = co2.select {|line| line[i] == "0"}
  end

  final_c = co2.first if co2.size == 1
end

p final_o
p final_c
p final_o.to_i(2) * final_c.to_i(2)
