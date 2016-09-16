require_relative 'board.rb'
require 'byebug'


class Game

  def initialize(board=Board.new(Board.generate_grid))
    @board = board
  end

  def play
    @board.render
    until won? || lost?
      play_turn
      @board.render
    end

    puts "You win!" if won?
    puts "You lost!" if lost?
  end

  def play_turn

    while true
      puts "Pick a coordinate"
      pos = parse_pos(gets.chomp)
      if valid_pos?(pos)
        break
      else
        puts "Invalid move"
      end
    end
    @board.update_board(pos)
  end

  def parse_pos(pos)
    pos.split(",").map { |char| Integer(char)}
  end

  def valid_pos?(pos)
        #debugger
    if pos.is_a?(Array) &&
      pos.length == 2 &&
      !@board[pos].revealed &&
      pos.all? { |x| x.between?(0, @board.size - 1) }
      return true
    else
      false
    end
  end

  def valid_flag?(pos)

  end

  def won?
    @board.flatten.all? {|tile| tile.revealed unless tile.bomb}
  end

  def lost?
    @board.flatten.any? {|tile| tile.revealed && tile.bomb}
  end

end

game = Game.new.play
