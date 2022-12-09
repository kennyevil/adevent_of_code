def input_data
  file = File.open("input.txt")
  file_data = file.read
  file.close

  @input_data = file_data.split("\n")
end

def record_tail_positions
  @head_position = [0,0]
  @tail_position = [0,0]
  @tail_positions = [[0,0]]

  @input_data.each do |instruction|
    direction, distance = instruction.split(" ")[0], instruction.split(" ")[1].to_i

    step = ["L", "D"].include?(direction) ? -1 : 1
    static_plane = ["U", "D"].include?(direction) ? 0 : 1
    moving_plane = ["L", "R"].include?(direction) ? 0 : 1

    record_tail_movement(distance, step, moving_plane, static_plane)
  end
end

def record_tail_movement(distance, step, moving_plane, static_plane)
  (1..distance).each do
    @head_position[moving_plane] += step

    next if (@head_position[0] - @tail_position[0]).abs <= 1 && (@head_position[1] - @tail_position[1]).abs <= 1

    @tail_position[static_plane] += 1 if @head_position[static_plane] > @tail_position[static_plane]
    @tail_position[static_plane] -= 1 if @head_position[static_plane] < @tail_position[static_plane]
    @tail_position[moving_plane] += step

    @tail_positions << @tail_position.dup
  end
end

def record_tail_positions_ten_knot_rope
  @knots = []
  10.times { @knots << [0, 0] }

  @ten_knotted_rope_tail_positions = [[0, 0]]

  @input_data.each do |instruction|
    direction, distance = instruction.split(" ")[0], instruction.split(" ")[1].to_i

    step = ["L", "D"].include?(direction) ? -1 : 1
    static_plane = ["U", "D"].include?(direction) ? 0 : 1
    moving_plane = ["L", "R"].include?(direction) ? 0 : 1

    record_ten_knot_tail_movement(distance, step, moving_plane, static_plane)
  end
end

def record_ten_knot_tail_movement(distance, step, moving_plane, static_plane)
  (1..distance).each do
    @knots.first[moving_plane] += step


    (1..9).each do |index|
      leading_knot = @knots[index - 1]
      lagging_knot = @knots[index]

      next if ((leading_knot[0] - lagging_knot[0]).abs <= 1 && (leading_knot[1] - lagging_knot[1]).abs <= 1)

      lagging_knot[static_plane] += 1 if leading_knot[static_plane] > lagging_knot[static_plane]
      lagging_knot[static_plane] -= 1 if leading_knot[static_plane] < lagging_knot[static_plane]
      lagging_knot[moving_plane] += step

      @ten_knotted_rope_tail_positions << @knots.last.dup if index == 9
    end
  end
end

input_data
record_tail_positions
record_tail_positions_ten_knot_rope

puts "There are #{@tail_positions.uniq.size} positions that the tail passed through"
puts "There are #{@ten_knotted_rope_tail_positions.uniq.size} positions that the tail passed through"
