passports = File.read('./input').split("\n\n")

REQUIRED_FIELDS = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
OPTIONAL_FIELDS = ['cid']

valid = []

passports.each do |passport|
  fields = passport.split(/[\s\n]/)

  valid << passport if REQUIRED_FIELDS.any? do |rf|
    fields.any? { |field| field.start_with? rf }
  end
end

p valid.count