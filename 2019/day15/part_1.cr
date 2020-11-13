require "../intcode"

input = InOutProxy.new
output = InOutProxy.new

location_code = 4
x = 0
y = 0

spawn do
  IntcodeComputer.new(File.read("input"), input, output).process
end

class Roboter
  getter :directions

  def initialize
    @directions = [
      1_i64, # north
      4_i64, # east
      2_i64, # south
      3_i64, # west
    ]
  end

  def current_direction
    directions.first
  end

  def turn_right
    directions.rotate!
  end

  def turn_random
    directions.shuffle!
  end
end

r = Roboter.new

until location_code == 2_i64
  input.write(r.current_direction)
  sleep(0.01)
  location_code = output.read

  case location_code
  when 0_i64
    r.turn_right
  when 1_i64
    case r.current_direction
    when 1_i64
      y += 1
    when 2_i64
      y -= 1
    when 3_i64
      x -= 1
    when 4_i64
      x += 1
    end
  end
  p [x, y]
end
