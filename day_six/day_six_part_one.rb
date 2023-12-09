# frozen_string_literal: false

require 'pry-byebug'

# Determine the number of ways you could beat the record in each race. 
# What do you get if you multiply these numbers together?
class BoatRace

  def initialize
    @races = {
      race_1: {
        time: 7,
        distance: 9
      },
      race_2: {
        time: 15,
        distance: 40
      },
      race_3: {
        time: 30,
        distance: 200
      }
    }

    
    @ways_to_win = [] # hmmm
  end

  def make_sense_of_race_data
    @races.each do |race|
      ways_to_win(race)
    end
  end

  # For each whole millisecond you spend at the beginning of the race holding down the button, 
  # the boat's speed increases by one millimeter per millisecond.
  def ways_to_win(race)
    speed = 0


    total_time = race.dig(1, :time)
    total_distance = race.dig(1, :distance)

    accelerate = 0
    for second in 0..total_time
      binding.pry

      if accelerate += 1
        speed += 1
      end
    end

  end



  def product(arr)  # is this the data format I want to pass? name it better?
    arr.reduce(&:*)
  end
end

race = BoatRace.new
puts race.make_sense_of_race_data

# Time:      7  15   30
# Distance:  9  40  200