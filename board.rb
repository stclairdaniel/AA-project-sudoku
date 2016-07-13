class Board

  def initialize(grid)
    @grid = grid
  end

  def self.from_file(file)
    rows = File.readlines(file).map(&:chomp)
    board = rows.map do |row|
      row.split("").map do |value|
        value = value.to_i
        Tile.new(value, value != 0)
      end
    end
    Board.new(board)
  end

  def update_value(row, col, value)
    tile = @grid[row][col]
    tile.value = value unless tile.given
  end

  def render
    @grid.each do |row|
      print row.map(&:to_s).join(' ')
      print "\n"
    end
  end

  def solved?
    sol = (1..9).to_a
    (0..8).each do |row|
      return false unless check_row(sol, row, @grid)
    end
    trans_grid = @grid.transpose
    (0..8).each do |col|
      return false unless check_row(sol, col, trans_grid)
    end
    check_squares(sol)
  end

  def check_row(sol, row, grid)
    row_values = @grid[row].map {|tile| tile.value}
    row_values.sort == sol
  end

  def check_squares(sol)
    squares = []
     row_thirds = @grid.each_slice(3).to_a
     row_thirds.each do |row_third|
       temp = []
       row_third.each do |row|
         temp << row.each_slice(3).to_a
       end
       zipped_squares = temp[0].zip(temp[1], temp[2]).map(&:flatten)
       zipped_squares.each { |zipped_square| squares << zipped_square}
     end
     squares.map! { |array| array.map { |tile| tile.value}}
     squares.all? { |square| square.sort == sol}
   end
end
