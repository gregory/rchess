module Rchess
  module Paths
    class King < Base
      def paths
        [basic_paths, rock_paths].flatten(1)
      end

      private

      def rock_paths
        [{x: -3, y: 0}, {x: 2, y: 0}].select do |delta|
          dstCoord = self.coord.apply_delta(delta)
          oponent_color = self.color == Piece::WHITE_COLOR ? Piece::BLACK_COLOR : Piece::WHITE_COLOR
          !self.board.coord_is_threatened_by_color?(dstCoord, oponent_color)
        end
      end

      def basic_paths
        [Bishop.new({coord: @coord, board: @board, power: 1}), Rook.new({coord: @coord, board: @board, power: 1})]
      end
    end
  end
end
