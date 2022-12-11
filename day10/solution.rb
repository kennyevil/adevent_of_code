def input_data
  file = File.open("input.txt")
  file_data = file.read
  file.close

  @input_data = file_data.split("\n")
end

def determine_signal_strengths
  @signal_strengths = []
  signal_strength = 1

  @input_data.each do |instruction|
    @signal_strengths << signal_strength

    next if instruction.match?(/\Anoop/)

    @signal_strengths << signal_strength
    signal_strength += instruction.split(" ")[1].to_i
  end
end

def show_signal_strengths
  cycles_to_be_measured = Array.new(6) { |index| 20 + 40 * index }

  @signal_strengths.each_with_index.map { |signal_strength, index| signal_strength * (index + 1) if cycles_to_be_measured.include? index + 1 }.compact.sum
end

def print_letters
  display = Array.new(240, " ")

  display.each_index do |index|
    horizontal_position = index % 40

    display[index] = "#" if (horizontal_position - @signal_strengths[index]).abs <= 1
  end

  display.each_slice(40) do |horizontal_row|
    puts "#{horizontal_row.join}"
  end
end

input_data
determine_signal_strengths
puts "The total signal strength is #{show_signal_strengths}"
print_letters
