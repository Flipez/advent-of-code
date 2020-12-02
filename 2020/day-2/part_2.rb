lines = File.readlines('./input')
valid_passwords = []

lines.each do |line|
  min, max, char, _, password = line.split(/[\s\-:]/)

  if (password[min.to_i - 1] == char) ^ (password[max.to_i - 1] == char)
    valid_passwords << password
  end
end

puts valid_passwords.count
