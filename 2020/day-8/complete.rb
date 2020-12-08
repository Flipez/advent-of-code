instructions = File.readlines('./input').map(&:split)

def run(code)
  line = 0
  acc = 0
  visited = []

  while (0...code.size).include?(line)
    instr = code[line][0]
    val = code[line][1].to_i

    break if visited.include? line
    visited << line

    case instr
    when 'acc'
      acc += val
      line += 1
    when 'jmp'
      line += val
    when 'nop'
      line += 1
    else
    end
  end

  [line, acc]
end


def repair(code)
  code.each_with_index do |instruction, line|
    next if instruction[0] == 'acc'

    code[line][0] = instruction[0] == 'jmp' ? 'nop' : 'jmp'
    reached_line, acc = run(code)

    return acc if reached_line >= code.size

	  code[line][0] = instruction[0] == 'jmp' ? 'nop' : 'jmp'
  end
end

p run(instructions)
p repair(instructions)