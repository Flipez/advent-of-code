passports = File.read('./input').split("\n\n")

# byr (Birth Year) - four digits; at least 1920 and at most 2002.
# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
# hgt (Height) - a number followed by either cm or in:
#     If cm, the number must be at least 150 and at most 193.
#     If in, the number must be at least 59 and at most 76.
# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
# pid (Passport ID) - a nine-digit number, including leading zeroes.
# cid (Country ID) - ignored, missing or not.

REQUIRED_FIELDS = {
  'byr' => 1920..2002,
  'iyr' => 2010..2020,
  'eyr' => 2020..2030,
  'hgt' => { cm: 150..193, in: 59..76 },
  'hcl' => /\A#[\da-f]{6}\z/,
  'ecl' => ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'],
  'pid' => /\A\d{9}\z/
}
OPTIONAL_FIELDS = ['cid']

valid = []

passports.each do |passport|
  fields = passport.split(/[\s\n]/)

  valid << passport if REQUIRED_FIELDS.all? do |rf|
    fields.any? { |field| field.start_with? rf[0].to_s } &&
      fields.all? do |field|
        key, value = field.split(':')

        case key
        when 'byr'
          REQUIRED_FIELDS[key].include? value.to_i
        when 'iyr'
          REQUIRED_FIELDS[key].include? value.to_i
        when 'eyr'
          REQUIRED_FIELDS[key].include? value.to_i
        when 'hgt'
          if value.delete! 'in'
            REQUIRED_FIELDS[key][:in].include? value.to_i
          elsif value.delete! 'cm'
            REQUIRED_FIELDS[key][:cm].include? value.to_i
          end
        when 'hcl'
          value.match? REQUIRED_FIELDS[key]
        when 'ecl'
          REQUIRED_FIELDS[key.to_s].include? value
        when 'pid'
          value.match? REQUIRED_FIELDS[key]
        when 'cid'
          true
        end
      end
  end
end

p valid.count