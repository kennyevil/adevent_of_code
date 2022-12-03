def input_data
  file = File.open("input.txt")
  file_data = file.read
  file.close

  file_data.split("\n")
end

def sack_priorities
  priorities_total = 0

  input_data.each do |sack|
    items = sack.split("")

    compartment1 = items[0..(items.size/2) - 1]
    compartment2 = items[(items.size/2)..(items.size)]

    common_letter = (compartment1 & compartment2).first

    priorities_total += letter_priority(common_letter)
  end

  priorities_total
end

def badge_sack_priorities
  badge_priorities_total = 0

  input_data.each_slice(3) do |group|
    common_letter = (group[0].split("") & group[1]&.split("") & group[2]&.split("")).first

    badge_priorities_total += letter_priority(common_letter)
  end

  badge_priorities_total
end


def letter_priority(letter)
  letter_priorities = {}

  alphabet = []
  ("a".."z").each { |character| alphabet << character }
  ("A".."Z").each { |character| alphabet << character }

  alphabet.each_with_index { |character, index| letter_priorities.merge!(character => index + 1) }

  letter_priorities[letter]
end

puts "The total for the priorities is #{sack_priorities}"
puts "The total for the badge priorities is #{badge_sack_priorities}"
