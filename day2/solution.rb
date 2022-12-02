MOVE_SCORE = {
  X: 1,
  Y: 2,
  Z: 3,
}

ROUND_SCORE = {
  A: { X: 3, Y: 6, Z: 0 },
  B: { X: 0, Y: 3, Z: 6 },
  C: { X: 6, Y: 0, Z: 3}
}

COMPLEX_MOVE_SCORE = {
  X: { A: 3, B: 1, C: 2 },
  Y: { A: 1, B: 2, C: 3 },
  Z: { A: 2, B: 3, C:1 }
}

COMPLEX_ROUND_SCORE = {
  X: 0,
  Y: 3,
  Z: 6,
}

def input_data
  file = File.open("input.txt")
  file_data = file.read
  file.close

  file_data.split("\n")
end

def tournament_score
  score = 0

  input_data.each { |game| score += result(game) }

  score
end

def result(game)
  round_score = ROUND_SCORE[game.split[0].to_sym][game.split[1].to_sym]
  player_score = MOVE_SCORE[game.split[1].to_sym]

  player_score + round_score
end

def complex_tournament_score
  score = 0

  input_data.each { |game| score += complex_result(game) }

  score
end

def complex_result(game)
  round_score = COMPLEX_ROUND_SCORE[game.split[1].to_sym]
  player_score = COMPLEX_MOVE_SCORE[game.split[1].to_sym][game.split[0].to_sym]

  round_score + player_score
end

puts "You have scored #{tournament_score} under the first strategy"
puts "You have scored #{complex_tournament_score} under the second strategy"
