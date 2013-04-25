# encoding: utf-8

require_relative "SlidingMove.rb"
require_relative "Piece.rb"

class Rook < Piece
  @@MOVES = [
    [0,1],
    [1,0],
    [0,-1],
    [-1,0]
  ]

  def initialize(color, coords, board)
    super(color, coords, board)
    @rep = (self.color == :b) ? "♜" : "♖"
  end
# REV: This executes our logic in so much more concise of a way. I'll have to remember to use modules from now on.
  include SlidingMove

  def move_set
    build_move_set(@@MOVES)
  end
end