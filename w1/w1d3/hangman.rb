class Hangman
  def self.start
    guessing_player = get_player("guessing")   
    checking_player = get_player("checking")        
    game = Hangman.new(guessing_player, checking_player)
    game.play
  end

  def initialize(guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
    @display_letters = []
    @turn = 0
    @misses = 0
  end

  def play
    get_secret_word
    display_secret_word
    turn until won? || @misses == 6
    game_over
  end
  
  private

  def self.get_player(type)
    puts "Is #{type} player a human? (y/n)"
    reply = gets.chomp.downcase
    player_type(reply)
  end

  def self.player_type(reply)
    return HumanPlayer.new if reply == "y"
    ComputerPlayer.new
  end

  def display_secret_word
    puts @display_letters.join("")
  end

  def game_over
    puts "You guessed the word in #{@turn} turns!" if won?
    puts "You failed to guess the word!" if @misses == 6
  end

  def get_guess
    guess = @guessing_player.guess
    positions = guess_positions(guess)
    modify_display(guess, positions)
    get_guess_response(guess, positions)
    return false if positions.empty?
    true
  end

  def get_guess_response(guess, positions)
    response_info = [guess, letter_frequency(guess), positions]
    @guessing_player.handle_guess_response(response_info)
  end

  def get_secret_word
    secret_length = @checking_player.pick_secret_word
    set_display_length(secret_length)
    @guessing_player.receive_secret_length(secret_length)
    puts "The word is #{secret_length} letters"
    secret_length
  end

  def guess_positions(guess)
    positions = @checking_player.check_guess(guess)
  end

  def letter_frequency(letter)
    @display_letters.count(letter)
  end

  def modify_display(letter, positions)
    positions.each { |idx| @display_letters[idx] = letter }
  end

  def set_display_length(length)
    length.times { @display_letters << "_" }
  end

  def turn
    @misses += 1 unless get_guess
    display_secret_word
    puts @misses
    @turn += 1
  end

  def won?
    !(@display_letters.include?("_"))
  end
end

class HumanPlayer
  def check_guess(guess)
    puts "The guess is #{guess}"
    puts "Which positions contain the letter? (separate with spaces)"
    positions = gets.chomp.split(' ').map { |pos| pos.to_i - 1 }
  end

  def guess
    puts "Enter a letter"
    gets.chomp.downcase
  end
  
  def pick_secret_word
    puts "Think of a word. How many letters are in it?"
    gets.chomp.to_i
  end

  def handle_guess_response(response_info)
  end
  
  def receive_secret_length(secret)
  end
end

class ComputerPlayer  
  def initialize
    @dictionary = File.readlines("dictionary.txt").map(&:chomp)
    @available_letters = ("a".."z").to_a
  end

  def check_guess(guess)
    positions = []
    letters = @secret_word.split('')
    letters.each_with_index do |letter, idx|
      positions << idx if letter == guess
    end
    positions
  end

  def guess
    guessed_letter = most_common_letter(@available_letters)
    @available_letters.delete(guessed_letter)
    guessed_letter
  end

  def handle_guess_response(response_info)
    letter, frequency, positions = response_info
    letter_frequency_filter(letter, frequency)
    position_filter(letter, positions)
  end

  def pick_secret_word
    @secret_word = @dictionary.sample
    @secret_word.length
  end

  def receive_secret_length(length)
    @dictionary.select! { |word| word.length == length }
  end
  
  private

  def letter_frequency(letter)
    frequency = 0
    @dictionary.each do |word|
      frequency += 1 if word.include?(letter)
    end
    frequency
  end

  def letter_frequency_filter(letter, frequency)
    @dictionary.select! do |word|
      word.count(letter) == frequency
    end
  end
  
  def position_filter(letter, positions)
    @dictionary.select! do |word|
      position_check_helper(letter, positions, word)
    end
  end
  
  def position_check_helper(letter, positions, word)
    positions.each do |position|
      return false unless word[position] == letter
    end
    true
  end
  
  def most_common_letter(letters)
    letter_frequencies = {}
    letters.each do |letter|
      letter_frequencies[letter] = letter_frequency(letter)
    end
    letter_frequencies.max_by { |k, v| v }.first  
  end
end

if __FILE__ == $PROGRAM_NAME
  Hangman.start
end