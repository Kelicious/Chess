# encoding: utf-8

require_relative "Piece.rb"

class Pawn < Piece
  def initialize(color, coords, board)
    super(color, coords, board)
    direction = (self.color == :b) ? 1 : -1
    @rep = (self.color == :b) ? "♟" : "♙"

    @moves = {
      :forw => [[direction, 0], [2 * direction, 0]],
      :diag => [[direction, 1], [direction, -1]]
    }
  end

  def move_set
    one_step_moves + two_step_moves + diagonal_moves
  end

  private

  def one_step_moves
    sq_to_add = [cur_row + @moves[:forw][0][0], cur_col + @moves[:forw][0][1]]
    valid_spot = Board.on_board?(sq_to_add) && (@board.get_piece(sq_to_add).nil?)
    valid_spot ? [sq_to_add] : []
  end

  def two_step_moves
    return [] if one_step_moves.empty?
    sq_to_add = [cur_row + @moves[:forw][1][0], cur_col + @moves[:forw][1][1]]
    valid_spot = Board.on_board?(sq_to_add) && (@board.get_piece(sq_to_add).nil?)
    ([1,6].include?(cur_row) && valid_spot) ? [sq_to_add] : []
  end

  def diagonal_moves
    result = []
    @moves[:diag].each do |drow, dcol|
      sq_to_add = [cur_row + drow, cur_col + dcol]
      sq_content = @board.get_piece(sq_to_add)
      (result << sq_to_add) if (sq_content && !same_color?(sq_content))
    end

    result
  end
end
