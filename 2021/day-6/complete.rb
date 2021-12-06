input = File.read("./input")
#input = File.readlines("./input")

days = 0

#fishes = input.split(",").map(&:to_i) . #part1

fishes = Hash.new(0)
input.split(",").map(&:to_i).each do |fish|
  fishes[fish] += 1
end

until days == 256 do
  #new_fishes = {}
  new_fishes = Hash.new(0)

  #fishes.each do |fish|
  #  new_fish = {}
  #  if fish == 0
  #    new_fishes << 6
  #    new_fishes << 8
  #  else
  #    new_fishes << fish - 1
  #  end
  #end

  fishes.each do |days_left, fishes|
    if days_left == 0
      new_fishes[6] += fishes
      new_fishes[8] += fishes
    else
      new_fishes[days_left - 1] += fishes
    end
  end

  #fishes = new_fishes

  days += 1
  fishes = new_fishes
end


p fishes.values.sum
#p fishes
