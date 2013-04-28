# encoding: utf-8

require_relative "Piece.rb"

class King < Piece
  def initialize(color, coords, board)
    super(color, coords, board)
    @rep = (self.color == :b) ? "♚" : "♔"
  end

  def move_set
    possible_moves = []

    (HORIZONTAL_DIRS + DIAGONAL_DIRS).each do |drow, dcol|
      sq_to_add = [cur_row + drow, cur_col + dcol]

      next unless Board.on_board?(sq_to_add)
      sq_content = @board.get_piece(sq_to_add)

      if sq_content.nil?
        possible_moves << sq_to_add
      else
        (possible_moves << sq_to_add) unless same_color?(sq_content)
      end
    end

    possible_moves
  end
end
