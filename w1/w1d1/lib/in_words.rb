class Integer
  def in_words
    number = self
    number_words = []
    under_twenty_in_words = { 0 => "zero", 1 => "one", 2 => "two", 3 => "three", 4 => "four", 5 => "five", 6 => "six", 7 => "seven", 8 => "eight", 9 => "nine", 10 => "ten", 11 => "eleven", 12 => "twelve", 13 => "thirteen", 14 => "fourteen", 15 => "fifteen", 16 => "sixteen", 17 => "seventeen", 18 => "eighteen", 19 => "nineteen" }
    tens_in_words = { 20 => "twenty", 30 => "thirty", 40 => "forty", 50 => "fifty", 60 => "sixty", 70 => "seventy", 80 => "eighty", 90 => "ninety" }
    return "zero" if number == 0
    if number >= 1000000000000
      number_words << (number/1000000000000).in_words
      number_words << "trillion"
      number = number % 1000000000000
    end
    if number >= 1000000000
      number_words << (number/1000000000).in_words
      number_words << "billion"
      number = number % 1000000000
    end
    if number >= 1000000
      number_words << (number/1000000).in_words
      number_words << "million"
      number = number % 1000000
    end
    if number >= 1000
      number_words << (number/1000).in_words
      number_words << "thousand"
      number = number % 1000
    end
    if number >= 100
      number_words << (number / 100).in_words
      number_words << "hundred"
      number = number % 100
    end
    if number >= 20
      ones = number % 10
      number_words << tens_in_words[number - ones]
      number = number % 10
    end
    if number > 0
      number_words << under_twenty_in_words[number]
    end
    number_words.join(' ')
  end
end