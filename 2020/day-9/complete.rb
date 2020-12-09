numbers = File.readlines("input").map(&:to_i)

invalid = numbers[25..numbers.size].each_with_index do |number, index|
  break number unless numbers[index..(index + 24)].combination(2).map(&:sum).include?(number)
end

puts invalid

(2..numbers.size).each do |number_index|
  numbers.each_cons(number_index) do |con|
    if con.sum == invalid
      puts con.min + con.max
      return
    end
  end
end