lines = File.read("input").split("\n").compact

total_fuel = lines.map do |mass|
  ((mass.to_i / 3).floor - 2).to_i
end

puts "Required fuel part 1: #{total_fuel.sum}"