original_intcodes = File.read("input").split(",")
outputs = [] of Int32
original_inputs = [0,1,2,3,4].permutations.to_a

def parse_parameter_value(position, mode, intcodes)
  case mode
  when 0
    value_position = intcodes[position.to_i]
    intcodes[value_position.to_i]
  when 1
    intcodes[position.to_i]
  end
end

def calculate_output(intcodes, inputs, start_value, iteration, outputs)
  original_intcodes = intcodes
  current_position = 0
  current_opcode = 0
  input_count = 0

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
        if input_count == 0
          intcodes[target.to_i] = inputs[iteration].to_s
        elsif input_count == 1
          intcodes[target.to_i] = start_value.to_s
        end
        input_count += 1
        current_position += 2
      end
    when 4
      next_start_value = parse_parameter_value(current_position + 1, first_parameter_mode, intcodes) 
      if iteration == 4 && next_start_value
        outputs << next_start_value.to_i
        break
      else
        calculate_output(original_intcodes, inputs, next_start_value, iteration + 1, outputs) unless iteration == 4
        current_position += 2
      end
    when 5
      a = parse_parameter_value(current_position + 1, first_parameter_mode, intcodes)
      b = parse_parameter_value(current_position + 2, second_parameter_mode, intcodes)

      if a && b
        if a.to_i.zero?
          current_position += 3
        else
          current_position = b.to_i
        end
      end
    when 6
      a = parse_parameter_value(current_position + 1, first_parameter_mode, intcodes)
      b = parse_parameter_value(current_position + 2, second_parameter_mode, intcodes)

      if a && b
        if a.to_i.zero?
          current_position = b.to_i
        else
          current_position += 3
        end
      end
    when 7
      a = parse_parameter_value(current_position + 1, first_parameter_mode, intcodes)
      b = parse_parameter_value(current_position + 2, second_parameter_mode, intcodes)
      c = intcodes[current_position + 3]

      if a && b && c
        if a.to_i < b.to_i
          intcodes[c.to_i] = 1.to_s
        else
          intcodes[c.to_i] = 0.to_s
        end
        current_position += 4
      end
    when 8
      a = parse_parameter_value(current_position + 1, first_parameter_mode, intcodes)
      b = parse_parameter_value(current_position + 2, second_parameter_mode, intcodes)
      c = intcodes[current_position + 3]

      if a && b && c
        if a.to_i == b.to_i
          intcodes[c.to_i] = 1.to_s
        else
          intcodes[c.to_i] = 0.to_s
        end
        current_position += 4
      end
    when 99
      break
    end
  end
end

original_inputs.each do |inputs|
  # intcodes, inputs, start_Value, iteration
  output = calculate_output(original_intcodes, inputs, 0, 0, outputs)
end

p outputs.sort.last