input = File.readlines("./input2")

times = input[0].scan(/\d+/).flatten.map(&:to_i)
dists  = input[1].scan(/\d+/).flatten.map(&:to_i)

total_wins = []

times.each_with_index do |total_time, idx|
  wins = 0
  (0..total_time).to_a.each do |hold_duration|
    travel_distance = hold_duration * (total_time - hold_duration)

    if travel_distance > dists[idx]
      wins += 1
    end 
  end

  total_wins << wins
end

p total_wins
p total_wins.inject(:*)