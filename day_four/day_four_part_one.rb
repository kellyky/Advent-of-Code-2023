require 'pry-byebug'
cards = File.read('input.txt').split("\n")

class ScratchCardPileReader
  attr_reader :total_value

  def initialize(cards)
    @cards = cards
    @total_value = 0
  end

  def parse_cards
    @cards.each do |card|
      parse_raw_card_values(card)
    end
  end

  def parse_raw_card_values(card)
    @card_id, card_values = card.split(":")
    winning_number_list, card_numbers = card_values.split("|")
    @winning_numbers = winning_number_list.split
    @card_numbers = card_numbers.split

    winning_numbers
    value_of_card
  end

  def winning_numbers
    @winning_matches = @winning_numbers.select do |num|
      @card_numbers.include?(num)
    end
    
  end

  def value_of_card
    points = 0
    @winning_matches.each do |win|
      if win == @winning_matches.first
        points += 1
      else
        points *= 2
      end
    end
   
    @total_value += points
  end

end


lotto = ScratchCardPileReader.new(cards)
lotto.parse_cards
puts lotto.total_value