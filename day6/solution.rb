def input_data
  file = File.open("input.txt")
  file_data = file.read
  file.close

  file_data.split("")
end

def find_marker(message_length)
  signal = input_data
  marker = 0

  (message_length - 1..signal.size).each do |index|
    break unless marker.zero?

    marker = index + 1 if signal[index - message_length + 1..index].uniq.size == message_length
  end

  puts "The marker is #{marker}"
end

find_marker(4)
find_marker(14)
