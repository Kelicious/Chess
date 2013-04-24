# encoding: utf-8

require_relative "Board.rb"
require_relative "HumanPlayer.rb"

class Chess
  attr_accessor :board

  def initialize
    @board = Board.new
    @b = HumanPlayer.new(:b)
    @w = HumanPlayer.new(:w)
  end

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

  def play
    greeting

    while true
      [@w, @b].each do |player|
        if !(@board.color_in_checkmate || @board.color_in_stalemate)
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
    s, f = nil, nil
    until @board.move_legal?(player.color, s, f)
      s, f = player.attempt_move
    end

    @board.move(s,f)
  end
end