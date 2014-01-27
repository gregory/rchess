require 'forwardable'
module Rchess
  class Piece
    extend Forwardable

    TYPES={
      p: ->(coord, board){ Paths::Pawn.new(  {coord: coord, board: board}) },
      b: ->(coord, board){ Paths::Bishop.new({coord: coord, board: board}) },
      q: ->(coord, board){ Paths::Queen.new( {coord: coord, board: board}) },
      c: ->(coord, board){ Paths::Knight.new({coord: coord, board: board}) },
      r: ->(coord, board){ Paths::Rook.new(  {coord: coord, board: board}) },
      k: ->(coord, baord){ Paths::King.new(  {coord: coord, board: board}) }
    }

    WHITE_COLOR = :white
    BLACK_COLOR = :black

    COLORS={
      WHITE_COLOR => :downcase,
      BLACK_COLOR => :upcase
    }

    def_delegators :@coord, :x, :y
    def_delegators :paths, :destinations

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

    def direction
      #TODO: make it more dynamic
      self.color == WHITE_COLOR ? :up : :down
    end

    def type
      @type ||= @board.box_at_coord(@coord)
    end

    def can_goto_coord?(coord)
      destinations.flatten.any?{|dest| dest.x == coord.x && dest.y == coord.y }
    end

    def is_threaten?
      false #TODO: implement
    end

    private

    def paths
      @paths ||= TYPES[self.type.downcase].call(@coord, @board)
    end
  end
end
