class Game
  
  def initialize(codemaker, codebreaker)
    @codemaker = codemaker
    @codebreaker = codebreaker
  end
  
  def get_solution(codemaker)
    @solution = codemaker.solution     
  end
  
  def get_guess(codebreaker)
    codebreaker.guess
  end
  
  def play(turns)
    get_solution(@codemaker)
    turns.times do
      guess = get_guess(@codebreaker)
      if guessed?(guess)
        puts "You guessed the code"
        break
      end
      matches = guess.matches(@solution)
      @codebreaker.get_matches(matches)
    end
  end
  
  def guessed?(guess)
    guess.exact_matches(@solution) == 4
  end
  
  def self.start
    puts "Is codemaker a human or a computer player? (h for human, c for cpu)"
    choice = gets.chomp
    if choice == 'h'
      codemaker = HumanPlayer.new
    elsif choice == 'c'
      codemaker = ComputerPlayer.new
    end
      
    puts "Is codebreaker a human or a computer player? (h for human, c for cpu)"
    choice = gets.chomp
    if choice == 'h'
      codebreaker = HumanPlayer.new
    elsif choice == 'c'
      codebreaker = ComputerPlayer.new
    end
    
    game = Game.new(codemaker, codebreaker)
    game.play(10)
  end
end

VALID_COLORS = [:R, :G, :B, :Y, :O, :P]

class HumanPlayer
  def guess
    puts "Please enter a guess"
    Code.parse(gets.chomp)
  end
  
  def solution
    puts "Please enter a solution"
    Code.parse(gets.chomp)
  end
  
  def get_matches(matches)
    puts "You got #{matches[0]} exact matches and #{matches[1]} near matches"
  end
end 

class ComputerPlayer
  def guess
    Code.random
  end
  
  def solution
    Code.random
  end
  
  def get_matches(matches)
    
  end

end

class Code
  def initialize
    @code = []
  end
  
  def code
    @code
  end
  
  def code=(code)
    @code = code
  end
  
  def valid_colors
    @valid_colors
  end
  
  def self.parse(input)
    input_code = Code.new
    input_code.code = input.split('').map do |color|
      color.upcase.to_sym
    end
    raise "Invalid code" unless input_code.valid_length? && input_code.valid_colors_code?
    input_code
  end
  
  def self.random
    random_code = Code.new
    4.times do
      random_code.code << VALID_COLORS.sample 
    end  
    random_code
  end
  
  def valid_colors_peg?(peg)
    VALID_COLORS.include?(peg)
  end
  
  def valid_length?
    self.code.length == 4
  end
  
  def valid_colors_code?
    self.code.each do |peg|
      return false unless valid_colors_peg?(peg)    
    end
    true
  end
  
  def exact_matches(other_code)
    matches = 0
    (0..3).each do |i|
      matches += 1 if other_code.code[i] == self.code[i]
    end
    matches
  end
  
  def near_matches(other_code)
    matches = 0
    guess_colors = self.color_frequency
    solution_colors = other_code.color_frequency
    guess_colors.keys.each do |color|
      if solution_colors.keys.include?(color)
        if guess_colors[color] < solution_colors[color]
          matches += guess_colors[color]
        else
          matches += solution_colors[color]
        end
      end
    end
    matches
  end
  
  def matches(other_code)
    exact = self.exact_matches(other_code)
    near = self.near_matches(other_code) - exact
    [exact, near]
  end
  
  def color_frequency
    color_frequencies = Hash.new(0)
    self.code.each do |color|
      if color_frequencies.include?(color)
        color_frequencies[color] += 1
      end
    end
    color_frequencies
  end
end