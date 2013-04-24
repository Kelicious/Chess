# encoding: utf-8

require_relative "SlidingMove.rb"
require_relative "Piece.rb"
# REV: Clean, clear, simple.
class Bishop < Piece
  @@MOVES = [
    [1,1],
    [1,-1],
    [-1,1],
    [-1,-1]
  ]

  def initialize(color, coords, board)
    super(color, coords, board)
    @rep = (self.color == :b) ? "♝" : "♗"
  end

  include SlidingMove

  def move_set
    build_move_set(@@MOVES)
  end
end