module Rchess
  class Game
    include Wisper::Publisher
    COLORS = [:white, :black]

    attr_accessor :board
    attr_reader :players

    def add_player(player, color)
      #TODO: validate that the color has not been picked
      raise InvalidArgument.new("Unknown color - Choose among: #{COLORS.join(', ')}") unless COLORS.include? color

      players[player.uuid] = {color: color, player: player}
    end

    def players
      @players ||= Hash.new{ false }
    end

    def board
      @board ||= Board.new
    end
  end
end
