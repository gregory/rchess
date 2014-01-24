module Rchess
  class Piece
    TYPES={
      p: 'pawn',
      b: 'bishop',
      q: 'queen',
      c: 'knight',
      r: 'rook',
      k: 'king'
    }

    COLORS={
      white: :downcase,
      black: :upcase
    }

    attr_accessor :coord, :type

    def initialize(options)
      self.type  = options.fetch(:type, TYPES.invert['pawn'])
      self.coord = options.fetch(:coord)
    end

    def type=(value)
      raise ArgumentError.new("Unknown type #{value}") unless TYPES.keys.include?(value.downcase)
      @type = value
    end

    def color
      return @color if @color
      cases = COLORS.invert
      @color = self.type == self.type.downcase ? cases[:downcase] : cases[:upcase]
    end
  end
end
