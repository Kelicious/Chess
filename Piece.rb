# encoding: utf-8

require_relative "Board.rb"

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