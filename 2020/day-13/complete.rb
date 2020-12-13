require './chinese_remainder.rb'

schedule = File.readlines('./input_test')
min = nil
min_bus = nil
id = schedule[0].to_f
buses = schedule[1].split(',')

buses.each do |bus|
  next if bus == 'x'
  bus = bus.to_i
  new_min = ((id / bus).ceil) * bus - id
  if min.nil? || new_min < min
    min = new_min
    min_bus = bus
  end
end

puts (min * min_bus).to_i

mods = []
indexes = []
buses.each_with_index do |bus, index|
  next if bus == 'x'
  mods << bus.to_i
  indexes << -index
end

p chinese_remainder(mods, indexes)