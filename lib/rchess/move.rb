module Rchess
  class Move
    attr_reader :piece

    def initialize(piece)
      @piece = piece
    end

    def available_destinations
      []
    end

    def board
      @piece.board
    end

    def coord
      @piece.box.to_coord
    end
  end
end
