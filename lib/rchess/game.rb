module Rchess
  class Game
    include Wisper::Publisher
    COLORS = [:white, :black]

    attr_accessor :board
    attr_reader :players, :turn

    def initialize
      @turn = :white
    end

    def add_player(player, color)
      #TODO: validate that the color has not been picked
      raise ArgumentError.new("Unknown color - Choose among: #{COLORS.join(', ')}") unless COLORS.include? color

      players[player.uuid] = {color: color, player: player, chess: false}
    end

    def player_moved(player, fromBox, toBox)
      publish(:you_are_frozen)           unless self.player_can_play?(player)
      publish(:you_occupy_this_position) unless self.player_dont_own_the_box?(player, toBox)
    end

    def players
      @players ||= Hash.new{ false }
    end

    def board
      @board ||= Board.new
    end

    def player_can_play?(player)
      self.players[player.uuid][:color] == self.turn
    end

    def player_own_box?(player, box)
      self.board.color_for_piece_at(box) == players[player.uuid][:color]
    end
  end
end
