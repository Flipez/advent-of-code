class IntcodeComputer
  getter :intcode
  property :position, :done

  def initialize(intcode : String, @in : InOutProxy, @out : InOutProxy)
    @position = 0_i64
    @done = false
    @relative_base = 0_i64
    @intcode = [] of Int64

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

  def add_output(output : Int64)
    @out.write(output)
  end

  private def parse_intcode(intcode)
    dummy = Array(Int64).new(1000, 0)
    @intcode = intcode.split(",").map do |code|
      code.to_i64
    end + dummy
  end

  private def move_position(offset : Int32)
    @position += offset
  end

  def process_current_position
    instr = "%05d" % intcode[position]
    opcode = instr[-2..-1].to_i64

    first_param_mode = instr[2].to_i64
    second_param_mode = instr[1].to_i64
    third_param_mode = instr[0].to_i64

    case opcode
    when 1
      a, b = param(1, first_param_mode), param(2, second_param_mode)
      target = find_target(3, third_param_mode)

      intcode[target] = (a + b)
      move_position(4)
    when 2
      a, b = param(1, first_param_mode), param(2, second_param_mode)
      target = find_target(3, third_param_mode)

      intcode[target] = (a * b)
      move_position(4)
    when 3
      target = find_target(1, first_param_mode)
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
      target = find_target(3, third_param_mode)

      if a < b
        intcode[target] = 1
      else
        intcode[target] = 0
      end
      move_position(4)
    when 8
      a, b = param(1, first_param_mode), param(2, second_param_mode)
      target = find_target(3, third_param_mode)

      if a == b
        intcode[target] = 1
      else
        intcode[target] = 0
      end
      move_position(4)
    when 9
      a = param(1, first_param_mode)
      @relative_base += a
      move_position(2)
    when 99
      @done = true
    end
  end

  private def param(offset : Int64, mode : Int64)
    case mode
    when 0
      value_position = intcode[position + offset]
      intcode[value_position]
    when 1
      intcode[position + offset]
    when 2
      value_position = intcode[position + offset]
      intcode[value_position + @relative_base]
    else
      raise Exception.new("Invalid mode")
    end
  end

  private def find_target(offset : Int64, mode : Int64)
    case mode
    when 0
      intcode[position + offset]
    when 2
      value_position = intcode[position + offset]
      value_position + @relative_base
    else
      raise Exception.new("Invalid mode")
    end
  end
end

class InOutProxy
  getter :buffer

  def initialize
    @buffer = [] of Int64
  end

  def read
    @buffer.shift
  end

  def write(value)
    @buffer.push(value)
  end
end

in_e = InOutProxy.new
e_out = InOutProxy.new
outputs = [] of Int64
IntcodeComputer.new(File.read("input"), in_e, e_out).process
e_out.buffer.each_slice(3) do |item|
  outputs << item[2] if item[2] == 2
end

p outputs.size
