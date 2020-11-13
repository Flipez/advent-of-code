require "../intcode"

input = InOutProxy.new
output = InOutProxy.new
IntcodeComputer.new(File.read("input"), input, output).process
