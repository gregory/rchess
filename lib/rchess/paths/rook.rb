module Rchess
  module Paths
    class Rook < Base
      def initialize(coord, power=8)
        @power = power
        super(coord)
      end

      def paths
        [linear_paths].flatten(1)
      end

      private

      def linear_paths
        [
          (1..@power).map{ |i| { x: 0,  y: i  } },
          (1..@power).map{ |i| { x: 0,  y: -i } },
          (1..@power).map{ |i| { x: i,  y: 0  } },
          (1..@power).map{ |i| { x: -i, y: 0  } }
        ]
      end
    end
  end
end
