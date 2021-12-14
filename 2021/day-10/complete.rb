input = File.readlines("./input")

open_chars = [
  "<",
  "(",
  "[",
  "{"
]

closing_op = {
  ">" => "<",
  ")" => "(",
  "]" => "[",
  "}" => "{"
}

sum = 0
total_scores = []
stop_line = false

input.each_with_index do |line, index|
  opens = []

  line.chomp.chars.each do |char|
    if open_chars.include?(char)
      opens << char
    else
      if opens.last == closing_op[char]
        opens.pop
      else
        opens = []
        sum += case char
               when ")"
                3
               when "]"
                57
               when "}"
                1197
               when ">"
                25137
               end

        break
      end
    end
  end

  if opens.any?
    total_score = 0
    p opens.reverse.join
    opens.reverse.each do |char|
      total_score = total_score * 5
      total_score += case char
                     when "("
                      1
                     when "["
                      2
                     when "{"
                      3
                     when "<"
                      4
                     end
    end
    total_scores << total_score
  end
end

p sum

total_scores = total_scores.sort
until total_scores.size == 1
  total_scores.pop
  total_scores.shift
end
p total_scores