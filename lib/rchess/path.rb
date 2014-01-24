module Rchess
  module Paths
    class Base
      attr_reader :srcCoord

      def initialize(coord)
        @srcCoord = coord
      end

      def destinations
        self.paths.map{ |path| apply_delta_to_path(path).delete_if{ |h| h[:x] < 0 || h[:y] < 0 } }
      end

      def paths
        raise NotImplementedError.new("You must implement paths")
      end

      private

      def apply_delta_to_path(path)
        path.map{ |delta| self.srcCoord.apply_delta(delta) }
      end
    end
  end
end
