input = File.readlines("./input")
sum = 0

input.each do |report|
  report = report.strip.split(" ").map{|n| n.to_i}

  valid = true
  decr = false
    p report

  diffs = report.each_cons(2).map do |a, b|
    a - b
  end

  sum+= 1 if diffs.all? {|diff| diff.between?(1,3) } or diffs.all? {|diff| diff.between?(-3,-1)}
end

p sum