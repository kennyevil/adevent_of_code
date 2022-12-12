def input_data
  file = File.open("input.txt")
  file_data = file.read.split("\n")
  file.close

  @input_data = []

  file_data.each_slice(7) do |slice|
    starting_items = determine_starting_items(slice[1])
    operation = determine_operation(slice[2])
    test = determine_test(slice[3])
    next_monkeys = determine_monkeys(slice[4], slice[5])

    @input_data << { items: starting_items, operation: operation, test: test, next_monkeys: next_monkeys }
  end
end

def determine_starting_items(string)
  string.split(/\:/)[1].split(/\,/).map(&:to_i)
end

def determine_operation(string)
  operation = string.split("old ")[1].split(" ")

  { operator: operation[0], amount: operation[1] }
end

def determine_test(string)
  string.match(/\d+/)[0].to_i
end

def determine_monkeys(string_one, string_two)
  monkey_one = string_one.match(/\d+/)[0].to_i
  monkey_two = string_two.match(/\d+/)[0].to_i

  { true: monkey_one, false: monkey_two }
end

def monkey_swapping(rounds)
  input_data
  inspections = []

  8.times { inspections << 0 }

  initial_inspection_run = rounds #> 20 ? 20 : rounds

  initial_inspection_run.times do
    @input_data.each_with_index do |monkey, index|
      inspections[index] += monkey[:items].size

      monkey[:items].each do |item|
        worry_level = determine_worry_level(item, monkey[:operation], rounds)
        next_monkey = determine_next_monkey(worry_level, monkey[:test], monkey[:next_monkeys])

        @input_data[next_monkey][:items] << worry_level
      end

      monkey[:items] = []
    end
  end

  puts inspections.max(2).join(" x ")
  puts "Monkey business after #{rounds} rounds: #{inspections.max(2).inject(:*)}"
end

def determine_next_monkey(worry_level, test, next_monkeys)
  return next_monkeys[:true] if worry_level % test == 0

  next_monkeys[:false]
end

def determine_worry_level(item, operation, rounds)
  amount = operation[:amount].match?("old") ? item : operation[:amount].to_i

  worry_level = [item, amount].inject(operation[:operator].to_sym).to_i

  return worry_level % [2, 3, 5, 7, 11, 13, 19].inject(:*) if rounds > 20

  (worry_level.to_f/3).floor.to_i
end

monkey_swapping(20)
monkey_swapping(10000)
