def num_to_s(num, base)
  digit_key = { 0 => "0", 1 => "1", 2 => "2", 3 => "3", 4 => "4", 5 => "5", 
    6 => "6", 7 => "7", 8 => "8", 9 => "9", 10 => "A", 11 => "B", 12 => "C", 
    13 => "D", 14 => "E", 15 => "F"}
  digits = []
  while num > 0
    digits << digit_key[num % base]
    num /= base
  end
  digits.reverse.join("")
end


def caesar_encode(string, shift)
  letters = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", 
    "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  string_letters = string.split('')
  encoded_letters = []
  string_letters.each do |letter|
    if letter == " "
      encoded_letters << letter
      next
    end
    encoded_position = (letters.index(letter) + shift) % 26
    encoded_letters << letters[encoded_position]
  end
  encoded_letters.join('')
end
puts num_to_s(5, 10)
puts num_to_s(5, 2)
puts num_to_s(234, 10)
puts num_to_s(234, 2)
puts num_to_s(234, 16)

puts caesar_encode("hello", 3)
puts caesar_encode("hello hello", 3)