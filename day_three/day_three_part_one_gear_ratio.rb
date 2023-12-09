require 'pry-byebug'

schematics = File.read('input.txt').split

class GearRatio
  attr_reader :numbers, :symbols, :total
  def initialize(schematics)
    @schematics = schematics
    @numbers = {}
    @symbols = {}
    @total = []
  end

  def format_schematic
    numbers = []
    @schematics.each.with_index do |schematic, i|
      numbers = {}
      symbol_list = {}

      schematic_numbers = schematic.scan(/\d+/)

      if schematic_numbers.any?
        schematic_numbers.each do |number|
          # binding.pry
          numbers[number] = number_indexes(schematic, number)
        end
      end

      x = schematic.gsub(".", "")
      symbols = x.scan(/[^0-9]+/).map{ |sym| sym.split('') }.flatten


      if symbols.any?
        symbols.each do |char|
          j = schematic.index(char)
          symbol_list[char] = j
          schematic.gsub(schematic[j], ".")
        end
      end  

      @numbers[i] = numbers
      @symbols[i] = symbol_list
    end
  end

  # FIXME - works with test data but lots of nills otherwise
  def number_indexes(schematic, number)
    number_length = number.length
    first_letter = number[0]
    first_letter_index = schematic.index(first_letter)

    # binding.pry
    index = 0
    while index < schematic.length
      if schematic.slice(first_letter_index, number_length) == number
        # binding.pry
        last_letter_index = first_letter_index + number_length
        number_indexes = (first_letter_index...last_letter_index).to_a
        schematic.gsub(schematic[schematic.index(first_letter)], "")

        return number_indexes
      else
        # schematic.gsub(schematic[schematic.index(first_letter)], "")
        index += 1
      end
    end

  end

  def find_adjacents
    @numbers.each.with_index do |number, i|
      puts "#{i}"
      schematic_index = number[0]
      schematic_numbers = number[1]
      schematic = @schematics[schematic_index]

      schematic_syms = @symbols[schematic_index]
      find_adjacent(schematic, i, schematic_syms, schematic_index, schematic_numbers)

      schematic_syms = @symbols[schematic_index - 1] unless schematic_index == 0
      find_adjacent(schematic, i, schematic_syms, schematic_index, schematic_numbers)

      schematic_syms = @symbols[schematic_index + 1] unless schematic_index == @schematics.index(@schematics.last)
      find_adjacent(schematic, i, schematic_syms, schematic_index, schematic_numbers)
    end
  end

  def find_adjacent(schematic, i, schematic_syms, schematic_index, schematic_numbers)
    
    if schematic_syms.any?
      if schematic_numbers.any?
        schematic_numbers.each do |num|
          number = num.dig(0)
          adjacent_range = num.dig(1)

          if adjacent_range.nil?
            # binding.pry # check adjacent range assignment

          end

          unless adjacent_range.empty?
            adjacent_range.unshift(adjacent_range.first - 1) unless adjacent_range.first == 0
            adjacent_range.push(adjacent_range.last + 1) unless adjacent_range.last == schematic.length - 1
          end

          if schematic_syms.values.any? { |val|  adjacent_range.any?(val) }
            @total << number
            @numbers[i][number] = []
          end
        end
      end
    end
  end
end

guide = GearRatio.new(schematics)
guide.format_schematic
guide.find_adjacents
puts guide.total.map(&:to_i).sum