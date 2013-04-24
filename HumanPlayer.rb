class HumanPlayer
  attr_accessor :color
# REV: :color could be an attr_reader
  def initialize(color)
    @color = color
  end

  def attempt_move
    puts "Please enter your move (e.g. e2 e4)"
    start, finish = gets.chomp.split # REV: crashes if not given a pair of coords
  end
end