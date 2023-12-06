# frozen_string_literal: false

require 'pry-byebug'

games = File.read('input.txt').split("\n")

# Determine sum of game ids that would be possible
# if the bag had been loaded with only CUBE_LIMITS
class CubeConundrum
  attr_reader :tally

  CUBE_LIMITS = { red: 12, green: 13, blue: 14 }.freeze

  def initialize(games)
    @games = games
    @tally = 0
  end

  def parse_game
    @games.each do |game|
      game_id, game_scores = game.split(':')
      sets = game_scores.split(';')
      id = game_id.scan(/[0-9]/).join.to_i

      @tally += id if scores_within_limits?(sets)
    end
    @tally
  end

  def scores_within_limits?(sets)
    sets.all? do |set|
      color_scores = set.split(',')
      color_scores_within_limits?(color_scores)
    end
  end

  def color_scores_within_limits?(color_scores)
    color_scores.all? do |color_score|
      numeric, color = color_score.split(' ')
      numeric.to_i <= CUBE_LIMITS[color.to_sym]
    end
  end
end

cubes = CubeConundrum.new(games)
cubes.parse_game
puts cubes.tally
