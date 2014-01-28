module Rchess
  module Paths
    class Pawn < Base
      def paths
        [move_forward, take_piece, move_2_if_first_move].select{|path| !path.empty?}
      end

      private

      def direction
        srcPiece.direction == :up ? -1 : 1
      end

      def srcPiece
        @srcPiece ||= self.board.piece_at_coord(self.coord)
      end

      def move_2_if_first_move
        if piece_first_move?
          [{x: 0, y: 2*direction}, {x: 0, y: 2*direction}]
        else
          []
        end
      end

      def piece_first_move?
        srcPiece.coord.y == 1 && srcPiece.direction == :down || srcPiece.coord.y == 6 && srcPiece.direction == :up
      end

      def take_piece
        [{x: 1, y: direction}, {x: -1, y: direction}].select do |delta|
          dstCoord = self.coord.apply_delta(delta)
          dstPiece = self.board.piece_at_coord(dstCoord)
          !dstPiece.nil? && dstPiece.direction != srcPiece.direction
        end
      end

      def move_forward
        [{x: 0, y: direction}].select do |delta|
          dstCoord = self.coord.apply_delta(delta)
          dstPiece = self.board.piece_at_coord(dstCoord)
          dstPiece.nil?
        end
      end
    end
  end
end
