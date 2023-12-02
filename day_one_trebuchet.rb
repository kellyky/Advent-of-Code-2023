require 'pry-byebug'
calibrations  = File.read("calibrations.txt").split

calibration_value_sum = calibrations.sum do |val| 
  digits = val.scan(/[0-9]/)
  (digits.first + digits.last).to_i
end

puts calibration_value_sum
