# encoding: utf-8

require_relative "Piece.rb"

class Pawn < Piece
  def initialize(color, coords, board)
    super(color, coords, board)
    m = 0 # REV: not clear what m is from variable name
    m = (self.color == :b) ? 1 : -1
    @rep = (self.color == :b) ? "♟" : "♙"

    @moves = {
      :forw => [[m,0], [2 * m,0]],
      :diag => [[m,1], [m,-1]]
    }
  end

  def move_set
    one_step_moves + two_step_moves + diagonal_moves
  end

  private

  def one_step_moves
    sq_to_add = [cur_x + @moves[:forw][0][0], cur_y + @moves[:forw][0][1]]
    valid_spot = Board.on_board?(sq_to_add) && (@board.get_piece(sq_to_add).nil?)
    valid_spot ? [sq_to_add] : []
  end

  def two_step_moves
    return [] if one_step_moves.empty?
    sq_to_add = [cur_x + @moves[:forw][1][0], cur_y + @moves[:forw][1][1]]
    valid_spot = Board.on_board?(sq_to_add) && (@board.get_piece(sq_to_add).nil?)
    ([1,6].include?(cur_x) && valid_spot) ? [sq_to_add] : []
  end

  def diagonal_moves
    result = []
    @moves[:diag].each do |dx, dy|
      sq_to_add = [cur_x + dx, cur_y + dy]
      sq_content = @board.get_piece(sq_to_add)
      (result << sq_to_add) if (sq_content && !same_color?(sq_content))
    end

    result
  end
end