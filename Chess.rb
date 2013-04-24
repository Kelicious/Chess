# encoding: utf-8

# REV: I do not have a lot of mud to sling. This is easy to read.
require_relative "Board.rb"
require_relative "HumanPlayer.rb"

class Chess
  attr_accessor :board

  def initialize
    @board = Board.new
    @b = HumanPlayer.new(:b)
    @w = HumanPlayer.new(:w)
  end
# REV: Not sure you need a greeting method
  def greeting
    puts "Welcome to chess!"
  end

  def end_game
    loser_color = @board.color_in_checkmate

    winner, loser = "", ""
    case loser_color
    when :w
      winner, loser = "Black", "White"
    when :b
      winner, loser = "White", "Black"
    else
      winner = "No"
    end

    puts "#{winner} player wins!"
    puts "#{loser} player, take some Chess lessons." if winner != "No"
  end
# REV: play loop makes it easy to tell how the game flows.
  def play
    greeting

    while true
      [@w, @b].each do |player|
        if !(@board.color_in_checkmate || @board.color_in_stalemate)
          # REV: Use the unless condition instead of 'if !'
          half_turn(player)
        end
      end

      break if (@board.color_in_checkmate || @board.color_in_stalemate)
    end

    end_game
  end

  def half_turn(player)
    @board.show
    color = player.color == :w ? "White" : "Black"
    puts "#{color} player's turn"
    s, f = nil, nil # REV: call them start, finish
    until @board.move_legal?(player.color, s, f)
      s, f = player.attempt_move
    end

    @board.move(s,f)
  end
end