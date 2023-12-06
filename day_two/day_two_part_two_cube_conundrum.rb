# frozen_string_literal: false

require 'pry-byebug'

games = File.read('input.txt').split("\n")

# For each game, finds the minimum set of cubes that must have been present.
# What is the sum of the power of these sets?
class CubeConundrum
  attr_reader :tally

  def initialize(games)
    @games = games
    @tally = 0
  end

  def parse_game
    @games.each do |game|
      _, game_scores = game.split(':')
      sets = game_scores.split(';')
      cube_products(sets)
    end
  end

  def initialize_or_reset_cube_count
    @cubes = { red: 0, green: 0, blue: 0 }
  end

  def cube_products(sets)
    initialize_or_reset_cube_count
    sets.map do |set|
      color_scores = set.split(',')
      cubes_needed(color_scores)
    end

    @tally += @cubes.values.reduce { |product, score| product * score }
  end

  def cubes_needed(color_scores)
    color_scores.each do |color_score|
      numeric, color = color_score.split(' ')
      @cubes[color.to_sym] = numeric.to_i if numeric.to_i > @cubes[color.to_sym]
    end
  end
end

cubes = CubeConundrum.new(games)
cubes.parse_game
puts cubes.tally
