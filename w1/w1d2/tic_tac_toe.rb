MAGIC_NUMBERS = {
  [1, 1] => 6, 
  [1, 2] => 1, 
  [1, 3] => 8, 
  [2, 1] => 7, 
  [2, 2] => 5, 
  [2, 3] => 3, 
  [3, 1] => 2, 
  [3, 2] => 9, 
  [3, 3] => 4
}

class Board
  attr_accessor :squares
  
  def initialize
    @squares = {}
    [1, 2, 3].product([1, 2, 3]).each do |pos|
      @squares[pos] = " "
    end
  end
  
  def empty?(pos)
    @squares[pos] == " "
  end
  
  def place_mark(pos,mark)
    @squares[pos] = mark if empty?(pos)
  end
  
  def triple_check(mark)
    positions = @squares.keys.select { |key| @squares[key] == mark }
    positions.combination(3).to_a.each do |triple|
      return true if triple_sum(triple)
    end
    false
  end
  
  def triple_sum(triple)
    triple.inject(0) { |sum, pos| sum + MAGIC_NUMBERS[pos] } == 15
  end
  
  def winner
    puts "Os win" if triple_check("O")
    puts "Xs win" if triple_check("X")
  end
  
  def won?
    triple_check("X") || triple_check("O")
  end
  
  def render
    puts " "
    puts @squares.values[6..8].join('|')
    puts '-----'
    puts @squares.values[3..5].join('|')
    puts '-----'
    puts @squares.values[0..2].join('|')
  end
end

class Game
  def initialize(x_player, o_player)
    @x_player = x_player
    @o_player = o_player
    @board = Board.new
  end
  
  def mark(player)
    player == @x_player ? "X" : "O"
  end
  
  def play
    active_player = @x_player
    turn = 0
    until @board.won? || turn == 9
      @board.render
      active_player.move(@board, mark(active_player))
      active_player = (active_player == @x_player ? @o_player : @x_player)
      turn += 1
    end
    puts "The game is over"
    unless @board.won?
      puts "The only winning move is not to play"
    end
    @board.winner
    @board.render
  end
end

class HumanPlayer

  def move(board, mark)
    puts "Enter a coordinate pair, separated by a comma and a space"
    position = gets.chomp.split(", ").map { |val| val.to_i } 
    if board.empty?(position)
      board.place_mark(position, mark)
    else
      puts "That move is not allowed"
      move(board, mark)
    end
  end
end

class ComputerPlayer
  
  def move(board, mark)
    free_pos = board.squares.keys.select { |key| board.squares[key] == " " }
    comp_pos = board.squares.keys.select { |key| board.squares[key] == mark }
    final_pos = free_pos.sample
    comp_pos.combination(2).to_a.each do |pair|
      free_pos.each do |pos|
        final_pos = pos if MAGIC_NUMBERS[pair[0]] + MAGIC_NUMBERS[pair[1]] + 
        MAGIC_NUMBERS[pos] == 15
      end
    end
    board.place_mark(final_pos, mark)
  end
end

def startup
  puts "Will the Xs be a human [H] or a computer [C]?"
  x_player = gets.chomp
  puts "Will the Os be a human [H] or a computer [C]?"
  o_player = gets.chomp
  x_player = (x_player == "H" ? HumanPlayer.new : ComputerPlayer.new)
  o_player = (o_player == "H" ? HumanPlayer.new : ComputerPlayer.new)
  game = Game.new(x_player, o_player)
  game.play
end

startup