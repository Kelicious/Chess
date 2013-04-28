# encoding: utf-8

require_relative "SlidingMove.rb"
require_relative "Piece.rb"

class Bishop < Piece
  include SlidingMove

  def initialize(color, coords, board)
    super(color, coords, board)
    @rep = (self.color == :b) ? "♝" : "♗"
  end

  def move_set
    build_move_set(DIAGONAL_DIRS)
  end
end
