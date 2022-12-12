def input_data
  file = File.open("input.txt")
  file_data = file.read.split("\n")
  file.close

  elevation = {}
  ("a".."z").each_with_index { |letter, index| elevation.merge!(letter => index ) }
  elevation.merge!("S" => 0)
  elevation.merge!("E" => 25)

  find_start_and_end_points(file_data)

  @input_data = file_data.map { |line| line.split("").map { |character| elevation[character] } }
end

def start_positions
  start_positions = []

  @input_data.each_with_index do |line, index|
    line.each_with_index do |elevation, i|
      start_positions << [index, i] if elevation == 0
    end
  end

  start_positions
end

def find_start_and_end_points(file_data)
  start_line = file_data.map { |line|  line if line.match?("S") }.compact.first
  end_line = file_data.map { |line|  line if line.match?("E") }.compact.first

  start_y = file_data.index(start_line)
  start_x = start_line.split("").index("S")
  @start_position = [start_y, start_x]

  end_y = file_data.index(end_line)
  end_x = end_line.split("").index("E")
  @end_position = [end_y, end_x]
end

def find_paths(start_positions)
  successful_paths = [1000]

  start_positions.each do |start_position|
    paths = [[start_position]]
    visited_spaces = [start_position]

    paths.each_with_index do |current_path, i|
      next if paths.map(&:size).max > successful_paths.min

      current_space = current_path.last

      next if (start_positions - [start_position] + ["non-viable", @end_position]).include? current_space

      next_viable_spaces = next_potential_spaces(current_space) - visited_spaces

      next_viable_spaces.each do |space|
        next if visited_spaces.include? space

        new_path = current_path.dup + [space]
        paths << new_path
        visited_spaces << space unless space == "non-viable"
        successful_paths << new_path.size - 1 if space == @end_position
      end
    end
  end

  puts "Fewest steps required: #{successful_paths.min}"
end

def next_potential_spaces(current_space)
  potential_spaces = []
  elevation = @input_data[current_space[0]][current_space[1]]

  [current_space[0] - 1, current_space[0] + 1].each do |y|
    next unless (0..@input_data.size - 1).include? y

    potential_spaces << [y, current_space[1]] unless @input_data[y][current_space[1]] - elevation > 1
  end

  [current_space[1] - 1, current_space[1] + 1].each do |x|
    next unless (0..@input_data.first.size - 1).include? x

    potential_spaces << [current_space[0], x] unless @input_data[current_space[0]][x] - elevation > 1
  end

  return ["non-viable"] if potential_spaces.empty?

  potential_spaces
end

input_data
find_paths([@start_position])
find_paths(start_positions)
