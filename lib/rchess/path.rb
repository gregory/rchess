module Rchess
  module Paths
    class Base
      attr_reader :coord
      attr_accessor :board

      def initialize(params)
        @coord = params.fetch(:coord)
        @board = params.fetch(:board)
      end

      def srcBox
        @srcBox ||= @board.box_at_coord(@coord)
      end

      def srcDirection
        @srcDirection ||= srcBox.downcase == srcBox ? -1 : 1 #:up or :down
      end

      def destinations
        @destinations ||= self.paths.map{ |path| apply_delta_to_path(path).delete_if{ |coord| coord.x < 0 || coord.y < 0 } }
      end

      def paths
        raise NotImplementedError.new("You must implement paths")
      end

      def self.threaten_destinations_from_coord(coord, board)
        params = { coord: coord, board: board }
        [
          Paths::Pawn.new(params).destinations, Paths::Bishop.new(params).destinations, Paths::Knight.new(params).destinations, Paths::Rook.new(params).destinations
        ].flatten(1)
      end

      private

      def apply_delta_to_path(path)
        path.map{ |delta| self.coord.apply_delta(delta) }
      end
    end
  end
end
