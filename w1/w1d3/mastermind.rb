class Game
  def self.start
    codemaker = get_player("codemaker")
    codebreaker = get_player("codebreaker")
    
    game = Game.new(codemaker, codebreaker)
    game.play(10)
  end

  def initialize(codemaker, codebreaker)
    @codemaker = codemaker
    @codebreaker = codebreaker
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

  private

  def self.get_player(role)
    puts "Is #{role} a human or a computer player? (h for human, c for cpu)"
    choice = gets.chomp
    if choice == 'h'
      player = HumanPlayer.new
    else
      player = ComputerPlayer.new
    end
    player
  end

  def get_solution(codemaker)
    @solution = codemaker.solution     
  end
  
  def get_guess(codebreaker)
    codebreaker.guess
  end

  def guessed?(guess)
    guess.exact_matches(@solution) == 4
  end
end

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
  VALID_COLORS = [:R, :G, :B, :Y, :O, :P]

  attr_accessor :code

  def initialize(code)
    @code = code
  end
  
  def self.parse(input)
    input_code = input.split('').map do |color|
      peg = color.upcase.to_sym
      raise "Invalid color" unless VALID_COLORS.include?(peg)
      peg
    end
    Code.new(input_code)
  end
  
  def self.random
    random_code = []
    4.times do
      random_code << VALID_COLORS.sample 
    end  
    Code.new(random_code)
  end
  
  def valid_length?
    self.code.length == 4
  end
  
  def valid_colors_code?
    self.code.each do |peg|
      return false unless VALID_COLORS.include?(peg)    
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
      matches += [guess_colors[color], other_code[color]].min
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