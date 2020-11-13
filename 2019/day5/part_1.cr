intcodes = File.read("input").split(",")
output = 0
input = 1

def parse_parameter_value(position, mode, intcodes)
  case mode
  when 0
    value_position = intcodes[position.to_i]
    intcodes[value_position.to_i]
  when 1
    intcodes[position.to_i]
  end
end

def calculate_output(intcodes, input)
  current_position = 0
  current_opcode = 0

  until current_opcode == 99
    instructions = "%05d" % intcodes[current_position].to_i
    current_opcode = instructions[-2..-1].to_i
    first_parameter_mode = instructions[2].to_i
    second_parameter_mode = instructions[1].to_i
    third_parameter_mode = instructions[0].to_i

    case current_opcode
    when 1
      a = parse_parameter_value(current_position + 1, first_parameter_mode, intcodes)
      b = parse_parameter_value(current_position + 2, second_parameter_mode, intcodes)
      target = intcodes[current_position + 3]

      if a && b && target
        intcodes[target.to_i] = (a.to_i + b.to_i).to_s
        current_position += 4
      end
    when 2
      a = parse_parameter_value(current_position + 1, first_parameter_mode, intcodes)
      b = parse_parameter_value(current_position + 2, second_parameter_mode, intcodes)
      target = intcodes[current_position + 3].to_i

      if a && b && target
        intcodes[target.to_i] = (a.to_i * b.to_i).to_s
        current_position += 4
      end
    when 3
      target = intcodes[current_position + 1]

      if target
        intcodes[target.to_i] = input.to_s
        current_position += 2
      end
    when 4
      puts "got opcode 4: #{parse_parameter_value(current_position + 1, first_parameter_mode, intcodes)}"
      current_position += 2
    when 99
      break
    end
  end

  intcodes[0]
end

p calculate_output(intcodes, input)
