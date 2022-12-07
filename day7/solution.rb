def input_data
  file = File.open("input.txt")
  file_data = file.read
  file.close

  file_data.split("\n")
end

def set_file_structure(instructions)
  current_location = []
  file_structure = []

  instructions.each do |instruction|
    if instruction.match?(/\A\$ cd /)
      folder = instruction.split(/\A\$ cd /)[1]

      current_location.pop && next if folder.match?(/\.\./)

      current_location.push folder
    elsif instruction.match?(/\A\d+/)
      file_size = instruction.split(" ")[0].to_i

      file_structure << { location: current_location.dup, size: file_size }
    end
  end

  file_structure
end

def measure_folder_sizes(file_structure)
  folder_sizes = {}

  file_structure.each do |file|
    (0..file[:location].size - 1).each do |index|
      folder = "/" + file[:location][1..index].join("/")

      if folder_sizes.key?(folder)
        folder_sizes[folder] += file[:size]
      else
        folder_sizes[folder] = file[:size]
      end
    end
  end

  folder_sizes
end

def folders_for_deletion_total_size(folder_sizes)
  folder_sizes.map { |k, v| v if v <= 100000 }.compact.sum
end

def smallest_large_directory_to_delete(folder_sizes)
  needed_space = folder_sizes["/"] - 40000000

  folder_sizes.map { |k, v| v if v >= needed_space }.compact.min
end

def find_folders_for_deletion
  file_structure = set_file_structure(input_data)
  folder_sizes = measure_folder_sizes(file_structure)

  puts "Size of all directories with a maximum size of 100000 is #{folders_for_deletion_total_size(folder_sizes)}"
  puts "Size of smallest directory that can be deleted #{smallest_large_directory_to_delete(folder_sizes)}"
end

find_folders_for_deletion
