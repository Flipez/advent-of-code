intcodes = File.read("input").split(",").map do |intcode|
  intcode.to_i
end

def calculate_output(verb, noun)
  intcodes = File.read("input").split(",").map do |intcode|
    intcode.to_i
  end
  current_position = 0
  current_opcode = 0
  
  intcodes[1] = verb
  intcodes[2] = noun
  
  until current_opcode == 99
    current_opcode = intcodes[current_position].to_i
    a = intcodes[current_position + 1].to_i
    b = intcodes[current_position + 2].to_i
    target = intcodes[current_position + 3].to_i  
  
    case current_opcode
    when 1
      intcodes[target] = intcodes[a].to_i + intcodes[b].to_i
    when 2
      intcodes[target] = intcodes[a].to_i * intcodes[b].to_i
    when 99
      break
    end
  
    current_position += 4
  end

  intcodes[0]
end

nouns = (0..99).to_a
verbs = (0..99).to_a
output = 0

nouns.product(verbs).each do |c|
  output = calculate_output(c[0], c[1])
  if output == 19690720
    puts "Verb=#{c[0]} and Noun=#{c[1]} for output #{output}"
    puts "Solution is #{100 * c[0] + c[1]}"
  end
end


