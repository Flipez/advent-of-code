input = 284639..748759
matching_numbers = 0

input.each do |number|
  digits = number.to_s.chars.map do |digit|
    digit.to_i
  end
  is_larger = [] of Bool
  digits.each_with_index{|d,i| is_larger << (d >= digits[i-1])}

  next unless is_larger[1..].all?

  %w(11 22 33 44 55 66 77 88 99).each do |double|
    if number.to_s.includes? double
      digit_s = double[0]
      index = number.to_s.index(double)


      next if number.to_s[index + 2] == digit_s

      matching_numbers += 1
      break
    end
  end
end

p matching_numbers