original_intcodes = File.read("input").split(",")
outputs = [] of Int32
original_inputs = [0, 1, 2, 3, 4].permutations.to_a

class IntcodeComputer
  getter :intcode, :outputs
  property :position, :done

  def initialize(intcode : String)
    @position = 0
    @done = false
    @intcode = [] of Int32
    @inputs = [] of Int32
    @outputs = [] of Int32

    parse_intcode(intcode)

    until done
      process_current_position
    end
  end

  def add_input(input : Int32)
    @inputs.push(input)
  end

  def next_input
    @inputs.shift
  end

  def add_output(output : Int32)
    @outputs.push(output)
  end

  def next_output
    @outputs.shift
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

IntcodeComputer.new(File.read("input"))
