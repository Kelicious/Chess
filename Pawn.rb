# encoding: utf-8

require_relative "Piece.rb"

class Pawn < Piece
  def initialize(color, coords, board)
    super(color, coords, board)
    case color
    when :w
      @rep = "♙"
    when :b
      @rep = "♟"
    end
  end

  def move_set
    possible_moves = []
    cur_x, cur_y = self.coords
    m = (self.color == :b) ? 1 : -1
    moves = {
      :forw => [[m,0], [2 * m,0]],
      :diag => [[m,1], [m,-1]]
    }


    # check if one step forward moves are allowed
    sq_to_add = [cur_x + moves[:forw][0][0], cur_y + moves[:forw][0][1]]
    one_step = Board.on_board?(sq_to_add) && (@board.get_piece(sq_to_add).nil?)
    if one_step
      possible_moves << sq_to_add
    end

    # check if two step forward moves are allowed
    sq_to_add = [cur_x + moves[:forw][1][0], cur_y + moves[:forw][1][1]]
    two_step = Board.on_board?(sq_to_add) && (@board.get_piece(sq_to_add).nil?)
    if (one_step && two_step) && [1,6].include?(cur_x)
      possible_moves << sq_to_add
    end

    # check if diagonal moves are allowed
    moves[:diag].each do |dx, dy|
      sq_to_add = [cur_x + dx, cur_y + dy]
      sq_content = @board.get_piece(sq_to_add)
      if sq_content && !same_color?(sq_content)
        (possible_moves << sq_to_add) unless same_color?(sq_content)
      end
    end

    possible_moves
  end
end