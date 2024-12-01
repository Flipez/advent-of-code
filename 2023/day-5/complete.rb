input = File.read("./input")

parts = input.split("\n\n")

seeds = parts[0].scan(/(\d+)/).flatten.map(&:to_i)

maps = []

parts[1..-1].each do |part|
  cur_map = {}
  lines = part.split("\n")

  cur_map["from"], cur_map["to"] = lines[0].split(" ")[0].split("-to-")

  

  cur_range = {"mapping" => {}}

  lines[1..-1].each do |line|
    source, dest, range = line.scan(/(\d+)/).flatten


    start_range = ((source.to_i)..(source.to_i+range.to_i)).to_a
    end_range = ((dest.to_i)..(dest.to_i+range.to_i)).to_a

    start_range.each_with_index do |e, idx|
      cur_range["mapping"][e] = end_range[idx]
    end
  end

  cur_map["range"] = cur_range


  maps << cur_map
end

p maps