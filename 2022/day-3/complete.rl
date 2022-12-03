input = IO.open("./input").lines()

double_chars = []

chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

foreach rucksack in input
  fh = rucksack[:rucksack.size()/2]
  sh = rucksack[rucksack.size()/2:]

  double_letter = ""

  foreach fchar in fh
    foreach schar in sh
      if (fchar == schar)
        double_letter = fchar
      end
    end
  end

  double_chars.yoink(double_letter)
end

sum = 0
foreach char in double_chars
  sum = sum + chars.find(char) + 1
end

puts("Part 1: %d".format(sum))

skip = 0
common_chars = []
foreach index, rucksack in input
  if (skip == 0)
    a = rucksack
    b = input[index + 1]
    c = input[index + 2]

    common_char = ""

    foreach achar in a
      foreach bchar in b
        foreach cchar in c
          if (achar == bchar)
            if (bchar == cchar)
              common_char = achar
            end
          end
        end
      end
    end
    
    common_chars.yoink(common_char)
    skip = 3
  end

  if (skip > 0)
    skip = skip -1
    next
  end
end

sum = 0
foreach char in common_chars
  sum = sum + chars.find(char) + 1
end

puts("Part 2: %d".format(sum))