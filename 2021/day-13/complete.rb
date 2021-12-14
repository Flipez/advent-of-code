input = File.readlines("./input", chomp: true)

dot_lines = input.select{|line| !line.start_with?("fold") && !line.empty?}.map{|d| d.split(",")}.map{|d| [d[0].to_i, d[1].to_i]}
instructions = input.select{|line| line.start_with?("fold")}.map{|i| i.split.last.split("=")}.map{|i| [i[0], i[1].to_i]}

instructions.each do |dir, fold|
  dot_lines = dot_lines.map { |dot|
      if dir == "x"
        new_pos = if dot[0] > fold
          fold - (dot[0] - fold)
        else
          dot[0]
        end

        [new_pos, dot[1]]
      else
        new_pos = if dot[1] > fold
          fold - (dot[1] - fold)
        else
          dot[1]
        end
        [dot[0], new_pos]
      end
  }
  dot_lines = dot_lines.uniq
  p dot_lines.length
end


def out(l)
  output = Hash.new
  dot_x = []
  dot_y = []

  l.map do |x, y|
    output[[x, y]] = true
    dot_x << x
    dot_y << y
  end
  (dot_y.min..dot_y.max).each do |y|
      (dot_x.min..dot_x.max).each do |x|
        if output[[x,y]]
          print "#"
        else
          print "\s"
        end
      end
      print "\n"
  end
end

out(dot_lines)