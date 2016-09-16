require_relative "tile.rb"
require 'byebug'

class Board

  attr_reader :grid

  def self.empty_grid
    Array.new(9) {Array.new(9) { Tile.new() }}
  end

  def self.place_bomb?
    num = rand(8)
    return true if num == 5
  end

  def self.place_bombs(grid)
    grid.each do |row|
      row.each do |tile|
        if place_bomb?
          tile.bomb = true
        else
          tile.bomb = false
        end
      end
    end
    grid
  end

  def self.generate_grid
    self.place_bombs(self.empty_grid)
  end

  def self.generate_numbers(grid)
    
  end

  def initialize(grid)
    @grid = grid
  end

  def render
    puts "  " + (0..8).to_a.join(" ")
    @grid.each_with_index do |row, i|
      puts "#{i} #{row.join(" ")}"
    end
  end


  def [](pos)
    x,y = pos
    grid[x][y]
  end

  def []=(pos,flag)
    x, y = pos
    tile = grid[x][y]
    tile.flag = !tile.flag
  end

  def size
    @grid.size
  end

  def update_board(pos)
    #debugger
    self[pos].reveal
  end

  #in progress -- accepting 2 args currently
  def adjacents(pos)
    result = []
    x = pos[0]
    y = pos[1]
    (x-1..x+1).each do |row|
      (y-1..y+1).each do |col|
        result << [row,col] unless [row,col] == pos ||
        self[row,col] == nil ||
        row < 0 || col < 0
      end
    end
    result
  end
  ## in progress
  def reveal_adjacents(pos)
    adjacent_blanks = adjacents(pos).select {|o_tile| o_tile.value == 0 && !o.tile.revealed}
    adjacent_blanks.each do |tile|
      adjacent_blanks << adjacents(tile).select {|tile| tile.value == 0}
      @grid[pos].reveal if !@grid[pos].reveal
    end

  end

end

#board = Board.new(Board.generate_grid)
#p board.grid
