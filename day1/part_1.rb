lines = File.read('input').split("\n")

total_fuel = lines.map do |mass|
  ((mass.to_i / 3.0).floor - 2).to_i
end

puts "Required fuel part 1: #{total_fuel.inject(0){|sum,x| sum + x }}"