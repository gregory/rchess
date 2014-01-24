module Rchess
  class PathBuilder
    attr_accessor :piece

    #TODO: clean the argument dependency
    def initialize(piece)
      @piece = piece
    end

    def paths
      path_decorator.map(&:paths).flatten(1)
    end

    def destinations
      path_decorator.map(&:destinations).flatten(1)
    end

    private

    def path_decorator
      case piece.type.downcase
      when :p
        [Paths::Pawn.new(piece.coord)]
      when :b
        [Paths::Bishop.new(piece.coord)]
      when :q
        [Paths::Bishop.new(piece.coord), Paths::Rook.new(piece.coord)].flatten(1)
      when :c
        [Paths::Knight.new(piece.coord)]
      when :r
        [Paths::Rook.new(piece.coord)]
      when :k
        [Paths::Bishop.new(piece.coord, 1), Paths::Rook.new(piece.coord, 1)].flatten(1)
      end
    end
  end
end
