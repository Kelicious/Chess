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
    p_row, b_row = (color == :w) ? [6,7] : [1,0]

    (0..7).each {|col| @grid[p_row][col] = Pawn.new(color, [p_row,col],self)}
    [0,7].each {|col| @grid[b_row][col] = Rook.new(color, [b_row,col],self)}
    [1,6].each {|col| @grid[b_row][col] = Knight.new(color, [b_row, col],self)}
    [2,5].each {|col| @grid[b_row][col] = Bishop.new(color, [b_row, col],self)}
    @grid[b_row][3] = Queen.new(color, [b_row,3], self)
    @grid[b_row][4] = King.new(color, [b_row,3], self)
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

  def get_piece(coords)
    @grid[coords[0]][coords[1]]
  end

  def piece_at(pos)
    get_piece(self.pos_to_coords(pos))
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
  attr_accessor :coords, :color, :rep, :board

  def initialize(color, coords, board)
    @color = color
    @coords = coords
    @board = board
  end

  def same_color?(other_piece)
    other_piece.color == @color
  end

  def move_set

  end
end

class Knight < Piece
  def initialize(color, coords, board)
    super(color, coords, board)
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
        sq_to_add = [x + i*dx, y + i*dy]

        next unless Board.on_board?(sq_to_add)
        sq_content = @board.get_piece(sq_to_add)

        if sq_content.nil?
          possible_moves << sq_to_add
        else
          (possible_moves << sq_to_add) unless same_color?(sq_content)
          break
        end
      end
    end

    possible_moves
  end
end

class Bishop < Piece
  def initialize(color, coords, board)
    super(color, coords, board)
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
  def initialize(color, coords, board)
    super(color, coords, board)
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
  def initialize(color, coords, board)
    super(color, coords, board)
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
  def initialize(color, coords, board)
    super(color, coords, board)
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
  def initialize(color, coords, board)
    super(color, coords, board)
    case color
    when :w
      @rep = "♙"
    when :b
      @rep = "♟"
    end
  end
end