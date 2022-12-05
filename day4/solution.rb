def input_data
  file = File.open("input.txt")
  file_data = file.read
  file.close

  file_data.split("\n")
end

def overlapping_pairs
  overlaps = 0

  input_data.each do |pair|
    first_group, second_group = pair.split(",")

    overlaps +=1 if overlap(first_group, second_group)
  end

  overlaps
end

def partially_overlapping_pairs
  overlaps = 0

  input_data.each do |pair|
    first_group, second_group = pair.split(",")

    overlaps += 1 if partial_overlap(first_group, second_group)
  end

  overlaps
end

def overlap(first_group, second_group)
  fg = first_group.split("-")
  sg = second_group.split("-")

  return true if fg[0].to_i <= sg[0].to_i && fg[1].to_i >= sg[1].to_i

  return true if fg[0].to_i >= sg[0].to_i && fg[1].to_i <= sg[1].to_i
end

def partial_overlap(first_group, second_group)
  fg = first_group.split("-")
  sg = second_group.split("-")

  return false if (fg[0].to_i > sg[1].to_i || fg[1].to_i < sg[0].to_i)
end

puts "There are #{overlapping_pairs} overlapping groups"
puts "There are #{partially_overlapping_pairs} partially overlapping groups"
