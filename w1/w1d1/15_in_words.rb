UNDER_TWENTY = { 0 => "zero", 1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five", 6 => "six", 
                 7 => "seven", 8 => "eight", 9 => "nine", 10 => "ten", 11 => "eleven", 12 => "twelve", 
                 13 => "thirteen", 14 => "fourteen", 15 => "fifteen", 16 => "sixteen", 17 => "seventeen", 
                 18 => "eighteen", 19 => "nineteen" }
TENS = { 20 => "twenty", 30 => "thirty", 40 => "forty", 50 => "fifty", 60 => "sixty", 70 => "seventy", 
         80 => "eighty", 90 => "ninety" }
MAGNITUDES = { 100 => "hundred", 1000 => "thousand", 1000000 => "million", 1000000000 => "billion", 
               1000000000000 => "trillion" }


class Integer
  def in_words
    number, mag_words = magnitude(self)
    if number >= 20
      number_words = over_twenty_words(number)
    else
      number_words = UNDER_TWENTY[number]
    end
    (mag_words + number_words).join(' ')
  end

  def magnitude(number)
    number_words = []
    MAGNITUDES.values.reverse.each do |mag|
      if number >= mag
        number_words << (number / mag).in_words
        number_words << MAGNITUDES[mag]
        number %= mag
      end
    end
    [number, number_words]
  end

  def over_twenty_words(number)
    ones = number % 10
    number_words << TENS[number - ones]
    if ones > 0
      number_words << UNDER_TWENTY[ones]
    end
    number_words
  end
end

puts 7.in_words
puts 17.in_words
puts 45.in_words
puts 117.in_words
puts 126.in_words
puts 7345.in_words
puts 23435.in_words
puts 413114.in_words
puts 40036.in_words
puts 1_888_259_040_036.in_words