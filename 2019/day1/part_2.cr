lines = File.read("input").split("\n")

total_fuel = 0
lines.each do |mass|
  while mass.to_i > 0
    required_fuel = ((mass.to_i / 3.0).floor - 2).to_i
    break if required_fuel <= 0
    
    total_fuel += required_fuel
    mass = required_fuel
  end
end

puts "Required fuel part 2: #{total_fuel}"