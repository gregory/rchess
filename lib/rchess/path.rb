module Rchess
  module Paths
    class Base
      attr_reader :coord
      attr_accessor :board

      def initialize(params)
        @coord = params.fetch(:coord)
        @board = params.fetch(:board)
      end

      def destinations
        @destinations ||= self.paths.map{ |path| apply_delta_to_path(path).delete_if{ |coord| coord.x < 0 || coord.y < 0 } }
      end

      def paths
        raise NotImplementedError.new("You must implement paths")
      end

      private

      def apply_delta_to_path(path)
        path.map{ |delta| self.coord.apply_delta(delta) }
      end
    end
  end
end
