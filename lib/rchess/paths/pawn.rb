module Rchess
  module Paths
    class Pawn < Base
      def paths
        [move_forward]
      end

      private

      def move_forward
        [{x: 0, y: 1}]
      end
    end
  end
end
