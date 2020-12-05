passes = File.readlines('./input')

ids = []

passes.each do |pass|
  row_range = 0..127
  seat_range = 0..7
  pass[0..6].chars.each do |char|
    row_range = case char
                when 'F'
                  row_range.each_slice((row_range.size/2.0).round).to_a.first
                when 'B'
                  row_range.each_slice((row_range.size/2.0).round).to_a.last
                end
  end

  pass[7..9].chars.each do |char|
    seat_range = case char
                when 'L'
                  seat_range.each_slice((seat_range.size/2.0).round).to_a.first
                when 'R'
                  seat_range.each_slice((seat_range.size/2.0).round).to_a.last
                end
  end
  ids << (row_range.first * 8) + seat_range.first

end

p ids.sort.last
p (ids.min..ids.max).sum - ids.sum