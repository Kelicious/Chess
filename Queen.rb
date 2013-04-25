# encoding: utf-8

require_relative "SlidingMove.rb"
require_relative "Piece.rb"

class Queen < Piece
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
    @rep = (self.color == :b) ? "♛" : "♕"
  end

  include SlidingMove
# REV: Just a thought, but did you ever test just adding a Rook and Bishop's move sets together?
# REV: Our queen's equivalent of build_move_set was just a sum like the following, and it worked fine.
# REV: eg. Bishop.new(current position, etc).move_set + Rook.new(current position, etc.).move_set
  def move_set
    build_move_set(@@MOVES)
  end
end