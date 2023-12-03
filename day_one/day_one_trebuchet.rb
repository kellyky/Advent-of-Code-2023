require 'pry-byebug'
calibrations  = File.read("calibrations.txt").split

class Calibration
  attr_reader :calibrations

  SPELLED_DIGITS = {
    'zero' => '0',
    'one' => '1',
    'two' => '2',
    'three' => '3',
    'four' => '4',
    'five' => '5',
    'six' => '6',
    'seven' => '7',
    'eight' => '8',
    'nine' => '9'
  }

  def initialize(calibrations)
    @calibrations = calibrations
  end

  def digitize(word)
    word.to_i == 0 ?  SPELLED_DIGITS[word] : word
  end

  def readings_sum
    @calibrations.sum do |val|
      @words = get_words(val)
      first_digit = get_first_digit(val)
      last_digit = get_last_digit(val)

      (first_digit + last_digit).to_i
    end
  end

  def get_words(val)
    SPELLED_DIGITS.keys.select{ |word| val.match?(word) }
  end

  def get_first_digit(val)
    val_word_digit = ""
    contenders = []

    i = 0
    while i < val.length
      if val[i].match?(/[0-9]/)
        contenders << [i, val[i]]
      else
        unless @words.empty?
          @words.each do |word|
            if val.slice(i, word.length) == word
              val_word_digit = val.slice(i, word.length)
              contenders << [i, val_word_digit]
            end
          end
        end
      end
      i += 1
    end

    contenders.uniq!
    digitize(contenders.min.last)
  end

  def get_last_digit(val)
    val_word_digit = ""
    contenders = []

    i = val.length - 1
    while i >= 0
      if val[i].match?(/[0-9]/)
        contenders << [i, val[i]]
      else
        @words.each do |word|
          if val.slice(i, word.length) == word
            val_word_digit = val.slice(i, word.length)
            contenders << [i, val_word_digit]
          end
        end
      end
      i -= 1
    end
    contenders.uniq!
    digitize(contenders.max.last)
  end
end

part_two = Calibration.new(calibrations)
puts part_two.readings_sum
