ar = File.readlines("./input")

valid_passwords = []

ar.each do |line|
  min, max, char, _, password = line.split(/[\s\-:]/)

  if (password[min.to_i-1] == char ) ^ (password[max.to_i - 1] == char)
    valid_passwords << password
  end
end

p valid_passwords.count