input = File.read("input").split("").map do |pixel|
  pixel.to_i
end

width = 25
height = 6

layer_size = width * height

layers = input.each_slice(layer_size).to_a

zeros = layers.map do |layer| 
  layer.count do |pixel|
    pixel.zero?
  end
end

layer_with_least_zeros = layers[zeros.each_with_index.min.last]

print "Part 1 result is: "
puts layer_with_least_zeros.count(1) * layer_with_least_zeros.count(2)

def get_pixel_value(layers, layer_index, position)
  layer = layers[layer_index]
  pixel = layer[position]
  if pixel == 2
    get_pixel_value(layers, layer_index + 1, position)
  else
    pixel
  end
end

final_layer = [] of Int32

layer_size.times do |position|
  final_layer << get_pixel_value(layers, 0, position)
end

puts "Part 2 result is:"
final_layer.each_slice(width) do |slice|
  puts slice.join.gsub('1', " ").gsub('0', '#')
end