def input_data
  file = File.open("input.txt")
  file_data = file.read
  file.close

  file_data.split("\n\n")
end

def load_crates(crates_data)
  crate_instructions = crates_data.split("\n").reverse

  crate_instructions.first.split.each { |instruction| @crates[instruction] = [] }

  crate_instructions[1..-1].each do |crate_instruction|
    load = crate_instruction.gsub(/\s/, "x").split("")

    (0..8).each do |index|
      crate_content = load[(4 * index) + 1]

      next if crate_content.nil? || crate_content.match("x")

      @crates[(index + 1).to_s].push crate_content
    end
  end
end

def instruction_set(instructions)
  instructions.split("\n").each do |instruction|
    i = {}

    instruction_numbers = instruction.scan(/\d+/)

    i[:amount] = instruction_numbers[0].to_i
    i[:start] = instruction_numbers[1]
    i[:finish] = instruction_numbers[2]

    @instructions.push i
  end
end

def enact_instructions(model_number)
  @instructions.each do |instruction|
    moved_items = @crates[instruction[:start]].pop(instruction[:amount])
    moved_items.reverse! if model_number == "9000"

    @crates[instruction[:finish]] += moved_items
  end
end

def cranemover(model_number)
  @crates = {}
  @instructions = []

  load_crates(input_data[0])
  instruction_set(input_data[1])
  enact_instructions(model_number)

  puts "The top items in the crates are #{@crates.values.map(&:last).join}"
end

cranemover("9000")
cranemover("9001")
