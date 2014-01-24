module Rchess
  class Game
    attr_accessor :board, :players
    attr_reader :current_player_color

    def initialize(players)
      self.players          = players
      @current_player_color = :white
    end

    def players=(value)
      @players = {}
      player_white = value.fetch(:white){ raise ArgumentError.new("Please provide a white player")}
      player_black = value.fetch(:black){ raise ArgumentError.new("Please provide a black player")}

      @players[player_black.uuid] = { color: :black, player: player_black }
      @players[player_white.uuid] = { color: :white, player: player_white }
    end

    def move(srcCoord, dstCoord)
      return false unless board.movement_within_board?(srcCoord, dstCoord)
      return false unless current_player_own_piece_at_coord?(srcCoord)
      #return false unless board.valid_move(srcCoord, dstCoord)
    end

    def current_player_own_piece_at_coord?(coord)
      board.piece_color_at_coord(coord) == current_player_color
    end

    def board
      @board ||= BoardBuilder.build
    end
  end
end
