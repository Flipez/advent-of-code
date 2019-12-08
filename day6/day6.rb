require 'set'
input = File.read('input')
connections = input.split("\n")
orbits = {}

connections.each do |connection|
  planet, orbiter = connection.split(')')
  orbits[orbiter] = Set.new([planet, orbits[planet].to_a].flatten.compact)

  orbits.each do |orbit, current_planet|
    if current_planet.include?(orbiter)
      orbits[orbit].merge([planet, orbits[planet].to_a].flatten.compact)
    end
  end
end

puts(orbits.values.inject(0) { |sum, planets| sum + planets.length })
puts((orbits['YOU'] - orbits['SAN']).length + (orbits['SAN'] - orbits['YOU']).length)
