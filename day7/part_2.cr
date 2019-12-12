class IntcodeComputer
  getter :intcode
  property :position, :done

  def initialize(intcode : String, @in : InOutProxy, @out : InOutProxy)
    @position = 0
    @done = false
    @intcode = [] of Int32

    parse_intcode(intcode)
  end

  def process
    until done
      process_current_position
    end
  end

  def next_input
    while true
      begin
        return @in.read
      rescue IndexError
        sleep(0.1)
        next
      end
    end
  end

  def add_output(output : Int32)
    @out.write(output)
  end

  private def parse_intcode(intcode)
    @intcode = intcode.split(",").map do |code|
      code.to_i
    end
  end

  private def move_position(offset : Int32)
    @position += offset
  end

  def process_current_position
    instr = "%05d" % intcode[position]
    opcode = instr[-2..-1].to_i

    first_param_mode = instr[2].to_i
    second_param_mode = instr[1].to_i
    third_param_mode = instr[0].to_i

    case opcode
    when 1
      a, b = param(1, first_param_mode), param(2, second_param_mode)
      target = intcode[position + 3]

      intcode[target] = (a + b)
      move_position(4)
    when 2
      a, b = param(1, first_param_mode), param(2, second_param_mode)
      target = intcode[position + 3]

      intcode[target] = (a * b)
      move_position(4)
    when 3
      target = intcode[position + 1]

      intcode[target] = next_input
      move_position(2)
    when 4
      output = param(1, first_param_mode)

      add_output(output)
      move_position(2)
    when 5
      a, b = param(1, first_param_mode), param(2, second_param_mode)

      if a.zero?
        move_position(3)
      else
        @position = b
      end
    when 6
      a, b = param(1, first_param_mode), param(2, second_param_mode)

      if a.zero?
        @position = b
      else
        move_position(3)
      end
    when 7
      a, b = param(1, first_param_mode), param(2, second_param_mode)
      target = intcode[position + 3]

      if a < b
        intcode[target] = 1
      else
        intcode[target] = 0
      end
      move_position(4)
    when 8
      a, b = param(1, first_param_mode), param(2, second_param_mode)
      target = intcode[position + 3]

      if a == b
        intcode[target] = 1
      else
        intcode[target] = 0
      end
      move_position(4)
    when 99
      @done = true
    end
  end

  private def param(offset : Int32, mode : Int32)
    case mode
    when 0
      value_position = intcode[position + offset]
      intcode[value_position]
    when 1
      intcode[position + offset]
    else
      raise Exception.new("Invalid mode")
    end
  end
end

class InOutProxy
  def initialize
    @buffer = [] of Int32
  end

  def read
    @buffer.shift
  end

  def write(value)
    @buffer.push(value)
  end
end

outputs = [] of Int32
permutations = [5, 6, 7, 8, 9].permutations.to_a
i = 1
permutations.each do |inputs|
  in_a = InOutProxy.new
  in_a.write(inputs[0])
  in_a.write(0)
  in_b = InOutProxy.new
  in_b.write(inputs[1])
  in_c = InOutProxy.new
  in_c.write(inputs[2])
  in_d = InOutProxy.new
  in_d.write(inputs[3])
  in_e = InOutProxy.new
  in_e.write(inputs[4])

  spawn do
    IntcodeComputer.new(File.read("input"), in_a, in_b).process
  end
  spawn do
    IntcodeComputer.new(File.read("input"), in_b, in_c).process
  end
  spawn do
    IntcodeComputer.new(File.read("input"), in_c, in_d).process
  end
  spawn do
    IntcodeComputer.new(File.read("input"), in_d, in_e).process
  end

  IntcodeComputer.new(File.read("input"), in_e, in_a).process

  output = in_a.read
  outputs << output
  p "#{i} of #{permutations.size}"
  i += 1
end

p outputs.sort.last
