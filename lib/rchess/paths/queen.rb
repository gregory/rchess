module Rchess
  module Paths
    class Queen < Base
      def paths
        [Bishop.new({coord: @coord, board: @board}), Rook.new({coord: @coord, board: @board})].flatten(1)
      end
    end
  end
end
