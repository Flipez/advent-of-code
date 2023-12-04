input = File.readlines("./input")

max_color = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

sum_ids = 0

input.each do |line|
  id = line.split(":")[0].scan(/\d+/)[0].to_i
  valid = true
  line = line.split(":")[1]
  sets = line.strip.split(";")

  sets.each do |set|
    set.split(",").each do |round|
      number, color = round.strip.split(" ")
      if max_color[color] < number.to_i
        valid = false
      end
    end
  end

  sum_ids += id if valid
end

p sum_ids
p "#####"

sum_power = 0
input.each do |line|
  min_color = {
    "green" => 0,
    "blue" => 0,
    "red" => 0
  }

  line = line.split(":")[1]
  sets = line.strip.split(";")

  sets.each do |set|
    set.split(",").each do |round|
      number, color = round.strip.split(" ")
      if min_color[color] == 0 || min_color[color] < number.to_i
        min_color[color] = number.to_i
      end
    end
  end

  sum_power += min_color.values.inject(:*)
end
 p sum_power