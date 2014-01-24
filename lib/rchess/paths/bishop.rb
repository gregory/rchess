module Rchess
  module Paths
    class Bishop < Base
      def initialize(coord, power=8)
        @power = power
        super(coord)
      end

      def paths
        [diag_paths].flatten(1)
      end

      private

      def diag_paths
        [
          (1..@power).map{ |i| { x: i,  y: i  } },
          (1..@power).map{ |i| { x: i,  y: -i } },
          (1..@power).map{ |i| { x: -i, y: i  } },
          (1..@power).map{ |i| { x: -i, y: -i } }
        ]
      end
    end
  end
end
