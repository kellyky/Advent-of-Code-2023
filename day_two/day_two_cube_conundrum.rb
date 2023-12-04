require 'pry-byebug'
games = File.read('input.txt').split("\n")

# sample_games = [
#   "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
#   "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
#   "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
#   "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
#   "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
# ]

#  Which games would have been possible if the bag had been loaded with only 12 red cubes, 13 green cubes, and 14 blue cubes. 
#  What is the sum of the IDs of those games?

class CubeConundrum
  attr_reader :tally

  CUBE_LIMITS = { red: 12, green: 13, blue: 14 }

  def initialize(games)
    @games = games
    @tally = 0
  end

  def parse_game
    @games.each do |game|
      game_id, game_scores = game.split(":")

      id = game_id.scan(/[0-9]/).join.to_i
      sets = game_scores.split(";")


      if set_scores_within_lmnits?(sets)
        @tally += id
      end
    end
    @tally
  end

  def set_scores_within_lmnits?(sets)
    sets.all? do |set|
      color_scores = set.split(",")
      color_scores_within_limits?(color_scores)
    end
  end

  def color_scores_within_limits?(color_scores)
    color_scores.all? do |color_score|
      numeric, color = color_score.split(" ")
      numeric.to_i <= CUBE_LIMITS[color.to_sym]
    end
  end
end

cubes = CubeConundrum.new(games)
cubes.parse_game
puts cubes.tally
