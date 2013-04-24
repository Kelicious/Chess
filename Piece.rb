# encoding: utf-8

require_relative "Board.rb"

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

  def cur_y
    self.coords[1]
  end
end