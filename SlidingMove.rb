require_relative "Board.rb"

module SlidingMove
  def build_move_set(moves)
    possible_moves = []

    moves.each do |drow, dcol|
      (1..7).each do |i|
        sq_to_add = [cur_row + i*drow, cur_col + i*dcol]

        next unless Board.on_board?(sq_to_add)
        sq_content = @board.get_piece(sq_to_add)

        if sq_content.nil?
          possible_moves << sq_to_add
        else
          (possible_moves << sq_to_add) unless same_color?(sq_content)
          break
        end
      end
    end

    possible_moves
  end
end
