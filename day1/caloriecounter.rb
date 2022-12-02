
def input_data
  file = File.open("input.txt")
  file_data = file.read
  file.close

  file_data.split("\n\n")
end

def total_calories_per_sack
  sacks = input_data.map { |ec| ec.split("\n") }

  sacks.each { |sack| sack.map!(&:to_i) }

  sacks.map(&:sum)
end

puts total_calories_per_sack.max.to_s + " total calories in biggest sack"
puts total_calories_per_sack.max(3).sum.to_s + " total calories in biggest sack"
