require 'set'

class WordChainer
  def initialize(dictionary)
    @dictionary = File.readlines(dictionary).map(&:chomp).to_set
  end

  def adjacent_words(word)
    adjacents = []
    candidates = []
    @dictionary.each do |other_word|
    	adjacents << other_word if adjacent_word?(word, other_word)
    end
    adjacents
  end

  def adjacent_word?(word, candidate)
    return false unless word.length == candidate.length
    matches = 0
    i = 0
    word.each_char do |char| 
      matches += 1 if char == candidate[i]
      i += 1
    end
    return false unless matches == (word.length - 1)
    true
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = {source => nil}
    until @current_words.empty? || @all_seen_words.include?(target)
      explore_current_words
    end
    build_path(target)
  end

  def explore_current_words
    new_words = []
    @current_words.each do |word|
      adjacent_words(word).each do |candidate|
        unless @all_seen_words.include?(candidate)
          new_words << candidate
          @all_seen_words[candidate] = word
        end
      end
    end
    @current_words = new_words
  end

  def build_path(target)
    path = [target]
    until path.include?(nil)
      path << @all_seen_words[path[-1]]
    end
    path[0...-1].reverse
  end
end