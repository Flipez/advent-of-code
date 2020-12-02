lines = File.readlines('./input')
valid_passwords = []

lines.each do |line|
  min, max, char, _, password = line.split(/[\s\-:]/)

  valid_passwords << password if password.count(char).between?(min.to_i, max.to_i)
end

puts valid_passwords.count
