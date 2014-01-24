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

    attr_accessor :coord, :type, :paths

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

    def coord=(value)
      #clean the cached variables
      @paths = nil
      @coord = value
    end

    def paths
      @paths ||= path_builder.paths.map{|path| path.delete_if{|h| h[:x] < 0 || h[:y] < 0}}.delete_if(&:empty?)
    end

    def destinations
      path_builder.destinations.delete_if(&:empty?)
    end

    def path_to_coord(coord)
      destinations.detect{ |coords| coords.include?(coord.to_hash) }
    end

    private

    def path_builder
      @path_builder ||= PathBuilder.new(self)
    end
  end
end
