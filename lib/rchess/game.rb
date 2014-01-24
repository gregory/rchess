module Rchess
  class Game
    attr_accessor :board, :players
    attr_reader :current_player, :check_player

    def initialize(players)
      self.players         = players
      @current_player  = :white
      @player_in_check = nil
    end

    def players=(value)
      @players = {}
      @players[:white] = value.fetch(:white){ raise ArgumentError.new("Please provide a white player")}
      @players[:black] = value.fetch(:black){ raise ArgumentError.new("Please provide a black player")}
    end

    def board
      @board ||= BoardBuilder.build
    end
  end
end
