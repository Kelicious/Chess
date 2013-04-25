class HumanPlayer
  attr_accessor :color

  def initialize(color)
    @color = color
  end

  def attempt_move
    puts "Please enter your move (e.g. e2 e4)"
    start, finish = gets.chomp.split
  end
end

# REV: Simple and clean, not much to say here.