# encoding: utf-8

require_relative "Board.rb"
# REV: This comment is regarding every piece related class, but I noticed
# REV: that you kept pretty strict parallel structure. As an outsider, it made it 
# REV: pretty easy to understand, even for the deviants like Pawn.
class Piece
  attr_accessor :coords, :color, :rep, :board

  def initialize(color, coords, board)
    @color, @coords, @board = color, coords, board
  end

  def same_color?(other_piece)
    other_piece.color == @color
  end

  def move_set

  end

  private

  def cur_x
    self.coords[0]
  end
# REV: Again, these little methods look really useful
  def cur_y
    self.coords[1]
  end
end