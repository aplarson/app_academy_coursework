def substrings(string)
  substrings = []
  (0...string.length).each do |first_letter|
    (first_letter...string.length).each do |last_letter|
      substrings << string[first_letter..last_letter]
    end
  end
  substrings.uniq
end

def subwords(string)
  dictionary = File.readlines("dictionary.txt").map(&:chomp)
  substrings = substrings(string)
  subwords = substrings.select do |substring|
    dictionary.include?(substring)
  end
  print subwords
end

substrings("cat")
subwords("bookkeeper")