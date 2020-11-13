require "../intcode"

input = InOutProxy.new
output = InOutProxy.new

IntcodeComputer.new(File.read("input"), input, output).process

output.buffer.each do |char|
  print char.chr
end
