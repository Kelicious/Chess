# encoding: utf-8

class Chess
  attr_accessor :board
end

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) {Array.new(8, nil)}

    setup_pieces(:w)
    setup_pieces(:b)
  end

  def setup_pieces(color)
    pawn_row, back_row = (color == :w) ? [6,7] : [1,0]

    (0..7).each {|col| @grid[pawn_row][col] = Pawn.new(color, [pawn_row,col])}
    [0,7].each {|col| @grid[back_row][col] = Rook.new(color, [back_row,col])}
    [1,6].each {|col| @grid[back_row][col] = Knight.new(color, [back_row, col])}
    [2,5].each {|col| @grid[back_row][col] = Bishop.new(color, [back_row, col])}
    @grid[back_row][3] = Queen.new(color, [back_row,3])
    @grid[back_row][4] = King.new(color, [back_row,3])
  end

  def display
    first_row = "  a b c d e f g h"
    result = [first_row]
    @grid.size.times {|i| result << display_row(i)}
    result
  end

  def display_row(i)
    r = (8 - i).to_s
    @grid[i].each {|sq| r << (sq.nil? ? "  " : " #{sq.rep}")}
    r
  end

  def piece_at(pos)
    x, y = self.pos_to_coords(pos)
    @grid[x][y]
  end

  def move(start, finish)
    move_piece(Board.pos_to_coords(start), Board.pos_to_coords(finish))
  end

  def move_piece(start, finish)
    x, y = start
    a, b = finish
    @grid[a][b] = @grid[x][y]
    @grid[a][b].coords = [a,b]
    @grid[x][y] = nil
  end

  def self.on_board?(pos)
    pos.all? {|coord| coord.between?(0, 7)}
  end

  def self.pos_to_coords(pos)
    letter, number = pos.split("")
    y = letter.ord - 'a'.ord
    x = 8 - number.to_i
    [x, y]
  end

  def self.coords_to_pos(coords)
    x, y = coords
    letter = (y.ord + 'a'.ord).chr
    number = 8 - x
    "#{letter}#{number}"
  end
end

class Piece
  attr_accessor :coords, :color, :rep

  def initialize(color, coords)
    @color = color
    @coords = coords
  end

  def move_set

  end
end

class Knight < Piece
  def initialize(color, coords)
    super(color, coords)
    case color
    when :w
      @rep = "♘"
    when :b
      @rep = "♞"
    end
  end

  MOVES = [
    [1,2],
    [2,1],
    [1,-2],
    [2,-1],
    [-1,2],
    [-2,1],
    [-1,-2],
    [-2,-1]
  ]

  def move_set
    MOVES.map do |dx, dy|
      [coords[0] + dx, coords[1] + dy]
    end.select {|coord| Board.on_board?(coord)}
  end
end

module SlidingMove
  def build_move_set(moves)
    possible_moves = []
    x,y = coords
    moves.each do |dx, dy|
      (1..7).each do |i|
        # sq_to_add = [x + i*dx, y + i*dy]
        # if square_clear?(sq_to_add) then add that square to possible_moves
        # else break
        possible_moves << [x + i*dx, y + i*dy]
      end
    end

    possible_moves.select {|coord| Board.on_board?(coord)}
  end
end

class Bishop < Piece
  def initialize(color, coords)
    super(color, coords)
    case color
    when :w
      @rep = "♗"
    when :b
      @rep = "♝"
    end
  end

  MOVES = [
    [1,1],
    [1,-1],
    [-1,1],
    [-1,-1]
  ]

  include SlidingMove

  def move_set
    build_move_set(MOVES)
  end
end

class Rook < Piece
  def initialize(color, coords)
    super(color, coords)
    case color
    when :w
      @rep = "♖"
    when :b
      @rep = "♜"
    end
  end

  MOVES = [
    [0,1],
    [1,0],
    [0,-1],
    [-1,0]
  ]

  include SlidingMove

  def move_set
    build_move_set(MOVES)
  end
end

class Queen < Piece
  def initialize(color, coords)
    super(color, coords)
    case color
    when :w
      @rep = "♕"
    when :b
      @rep = "♛"
    end
  end

  MOVES = [
    [0,1],
    [1,0],
    [0,-1],
    [-1,0],
    [1,1],
    [1,-1],
    [-1,1],
    [-1,-1]
  ]

  include SlidingMove

  def move_set
    build_move_set(MOVES)
  end
end

class King < Piece
  def initialize(color, coords)
    super(color, coords)
    case color
    when :w
      @rep = "♔"
    when :b
      @rep = "♚"
    end
  end

  MOVES = [
    [0,1],
    [1,0],
    [0,-1],
    [-1,0],
    [1,1],
    [1,-1],
    [-1,1],
    [-1,-1]
  ]

  def move_set
    MOVES.map do |dx, dy|
      [coords[0] + dx, coords[1] + dy]
    end.select {|coord| Board.on_board?(coord)}
  end
end

class Pawn < Piece
  def initialize(color, coords)
    super(color, coords)
    case color
    when :w
      @rep = "♙"
    when :b
      @rep = "♟"
    end
  end
end