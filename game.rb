require_relative 'tile'
require_relative 'board'

class Game

  def initialize(board)
    @board = board
  end

  def play
    until @board.solved?
      @board.render
      row, col, value = prompt
      @board.update_value(row, col, value)
    end
    @board.render
    puts "Congrats for being a nerd."
  end

  def prompt
    puts "Enter row,col,value: "
    row, col, value = gets.chomp.split(",").map(&:to_i)
    until valid?(row,col,value)
      puts "Not a valid move. Try again: "
      row, col, value = gets.chomp.split(",").map(&:to_i)
    end
    [row, col, value]
  end

  def valid?(*args)
    row, col, value = args.map(&:to_i)
    (0..8).cover?(row) && (0..8).cover?(col) && (1..9).cover?(value)
  end

end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(Board.from_file("sudoku1-almost.txt"))
  game.play
end
