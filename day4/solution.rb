def input_data
  file = File.open("input.txt")
  file_data = file.read
  file.close

  file_data.split("\n")
end

def overlapping_pairs
  input_data.map { |pair| pair if overlap(pair.split(",")[0], pair.split(",")[1]) }.compact.size
end

def partially_overlapping_pairs
  input_data.map { |pair| pair if partial_overlap(pair.split(",")[0], pair.split(",")[1]) }.compact.size
end

def overlap(first_group, second_group)
  fg = first_group.split("-")
  sg = second_group.split("-")

  return true if fg[0].to_i <= sg[0].to_i && fg[1].to_i >= sg[1].to_i

  fg[0].to_i >= sg[0].to_i && fg[1].to_i <= sg[1].to_i
end

def partial_overlap(first_group, second_group)
  fg = first_group.split("-")
  sg = second_group.split("-")

  fg[0].to_i <= sg[1].to_i && fg[1].to_i >= sg[0].to_i
end

puts "There are #{overlapping_pairs} overlapping groups"
puts "There are #{partially_overlapping_pairs} partially overlapping groups"
