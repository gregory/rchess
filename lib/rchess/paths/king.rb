module Rchess
  module Paths
    class King < Base
      def paths
        [Bishop.new({coord: @coord, board: @board, power: 1}), Rook.new({coord: @coord, board: @board, power: 1})].flatten(1)
      end
    end
  end
end
