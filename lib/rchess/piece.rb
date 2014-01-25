require 'forwardable'
module Rchess
  class Piece
    extend Forwardable

    TYPES={
      p: 'pawn',
      b: 'bishop',
      q: 'queen',
      c: 'knight',
      r: 'rook',
      k: 'king'
    }

    WHITE_COLOR = :white
    BLACK_COLOR = :black

    COLORS={
      WHITE_COLOR => :downcase,
      BLACK_COLOR => :upcase
    }

    def_delegators :@coord, :x, :y

    attr_reader :coord

    def initialize(options)
      @board = options.fetch(:board) #The environment
      @coord = options.fetch(:coord) #The position
    end

    def self.type_to_color(type, color)
      raise ArgumentError.new("Unknown color #{color}") unless COLORS.keys.include? color
      type.send(COLORS[color])
    end

    def color
      return @color if @color

      cases = COLORS.invert
      self.type.downcase == self.type ? cases[:downcase] : cases[:upcase]
    end

    def type
      @type ||= @board.box_at_coord(@coord)
    end

    def can_goto_coord?(coord)
      true #TODO: implement
    end

    def is_threaten?
      false #TODO: implement
    end
  end
end
