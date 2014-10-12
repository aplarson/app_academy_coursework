require 'set'

class WordChainer
  def initialize(dictionary)
    @dictionary = File.readlines(dictionary).map(&:chomp).to_set
  end

  def adjacent_words(word)
    adjacents = []
    candidates = []
    @dictionary.each do |other_word|
      word_letters = word.split('')
      candidate_letters = word.split('')
      (0...word.length).each do |null_letter|
      	word_letters.delete_at(null_letter)
      	candidate_letters.delete_at(null_letter)
    	adjacents << other_word if (word_letters == candidate_letters)
      end
    end
    adjacents.to_set
  end
end