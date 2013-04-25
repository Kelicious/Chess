# encoding: utf-8

require_relative "SlidingMove.rb"
require_relative "Piece.rb"

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
# REV: As was with the Rook, we knew that we were going to have to specify
# REV: dy,dx values, but just couldn't even imagine turning it into a
# REV: shared modules. We're not very good at DRY...
  def move_set
    build_move_set(@@MOVES)
  end
end