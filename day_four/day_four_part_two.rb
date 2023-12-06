# frozen_string_literal: true

require 'pry-byebug'

cards = File.read('input.txt').split("\n")

# Reads pile of cards & calculates total cards
class ScratchCardPileReader
  attr_reader :card_copies, :id

  def initialize(cards)
    @cards = cards
    @card_stack = {}
  end

  def parse_cards
    @cards.each do |original_card|
      parse_raw_card_values(original_card)
    end
    evaluate_cards
    count_card_stack
  end

  def parse_raw_card_values(original_card)
    id, card_values = original_card.split(':')
    @id = id.scan(/\d+/).first.to_i
    winning_number_list, card_numbers = card_values.split('|')
    @card_stack[@id] = {
      copies: 1,
      winning_numbers: winning_number_list.split,
      card_values: card_numbers.split
    }
  end

  def evaluate_cards
    @card_stack.each do |card_number, card_info|
      win_count = []

      card_info[:copies].times do
        win_count = winning_quantity(card_info[:winning_numbers], card_info[:card_values])
        win_count.each.with_index do |_, i|
          @card_stack[card_number + i + 1][:copies] += 1
        end
      end
    end
  end

  def winning_quantity(winning_numbers, card_numbers)
    winning_numbers.select { |num| card_numbers.include?(num) }
  end

  def count_card_stack
    @card_stack.sum { |_, card_info| card_info[:copies] }
  end
end

lotto = ScratchCardPileReader.new(cards)
puts lotto.parse_cards
