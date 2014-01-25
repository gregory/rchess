module Rchess
  class Game
    attr_accessor :board, :players
    attr_reader :current_player_color

    def initialize(players)
      self.players          = players
      @current_player_color = Piece::WHITE_COLOR
    end

    def players=(value)
      @players = {}
      player_white = value.fetch(:white){ raise ArgumentError.new("Please provide a white player")}
      player_black = value.fetch(:black){ raise ArgumentError.new("Please provide a black player")}

      @players[player_black.uuid] = { color: Piece::BLACK_COLOR, player: player_black }
      @players[player_white.uuid] = { color: Piece::WHITE_COLOR, player: player_white }
    end

    def move!(srcCoord, dstCoord)
      return false unless board.movement_within_board?(srcCoord, dstCoord)

      piece = board.piece_at_coord(srcCoord)
      return false unless piece
      return false unless current_player_own_piece?(piece)

      board.move_piece_to_coord!(piece, dstCoord)
    end

    def current_player_own_piece?(piece)
      current_player_color == piece.color
    end

    def board
      @board ||= BoardBuilder.build
    end
  end
end
