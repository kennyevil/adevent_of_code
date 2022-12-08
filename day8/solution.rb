def input_data
  file = File.open("input.txt")
  file_data = file.read
  file.close

  file_data.split("\n").map { |line| line.split("").map(&:to_i) }
end

def find_visible_trees
  invisible_trees = 0

  (1..97).each do |row|
    (1..97).each do |column|
      invisible_trees += 1 unless tree_visible_from_any_edge?(row, column)
    end
  end

  puts "There are #{input_data.flatten.size - invisible_trees} visible trees"
end

def tree_visible_from_any_edge?(row, column)
  tree = input_data[row][column]

  left_trees = input_data[row][0..column - 1]
  right_trees = input_data[row][column + 1..98]
  upper_trees = input_data[0..row - 1].map { |r| r[column] }
  lower_trees = input_data[row + 1..98].map { |r| r[column] }

  other_trees = [left_trees, right_trees, upper_trees, lower_trees].sort_by(&:size)

  other_trees.each { |trees| return true if visible_from_edge?(tree, trees) }

  false
end

def visible_from_edge?(tree, trees)
  trees.map { |t| t if t >= tree }.compact.size.zero?
end

def tree_scenic_score(row, column)
  tree = input_data[row][column]

  other_trees = []

  other_trees << input_data[row][0..column - 1].reverse
  other_trees << input_data[row][column + 1..98]
  other_trees << input_data[0..row - 1].map { |r| r[column] }.reverse
  other_trees << input_data[row + 1..98].map { |r| r[column] }

  directional_scenic_scores = []

  other_trees.each { |trees| directional_scenic_scores << scenic_score(tree, trees) }

  directional_scenic_scores.inject(:*)
end

def best_scenic_score
  scenic_scores = []

  (1..97).each do |row|
    (1..97).each do |column|
      scenic_scores << tree_scenic_score(row, column)
    end
  end

  puts "The best scenic score for a tree is #{scenic_scores.max}"
end

def scenic_score(tree, trees)
  visibility = trees.map.each_with_index { |t, i| i if t >= tree }.compact.min

  return trees.size if visibility.nil?

  visibility + 1
end

find_visible_trees
best_scenic_score
