# encoding: utf-8

require_relative "Piece.rb"

class King < Piece
  @@MOVES = [
    [0,1],
    [1,0],
    [0,-1],
    [-1,0],
    [1,1],
    [1,-1],
    [-1,1],
    [-1,-1]
  ]

  def initialize(color, coords, board)
    super(color, coords, board)
    case color
    when :w
      @rep = "♔"
    when :b
      @rep = "♚"
    end
  end

  def move_set
    possible_moves = []

    @@MOVES.each do |dx, dy|
      x,y = @coords
      sq_to_add = [x + dx, y + dy]

      next unless Board.on_board?(sq_to_add)
      sq_content = @board.get_piece(sq_to_add)

      if sq_content.nil?
        possible_moves << sq_to_add
      else
        (possible_moves << sq_to_add) unless same_color?(sq_content)
      end
    end

    possible_moves
  end
end