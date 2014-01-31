module Rchess
  module Paths
    class Pawn < Base
      def paths
        [move_forward, take_piece, move_2_if_first_move].select{|path| !path.empty?}
      end

      private

      def move_2_if_first_move
        if piece_first_move?
          [{x: 0, y: 2*srcDirection}, {x: 0, y: 2*srcDirection}]
        else
          []
        end
      end

      def piece_first_move?
        self.coord.y == 1 && self.srcDirection == 1 || self.coord.y == 6 && self.srcDirection == -1
      end

      def take_piece
        #TODO: remove the color notion, there is only 1 piece that goes up and one that goes down
        [{x: 1, y: srcDirection}, {x: -1, y: srcDirection}].select do |delta|
          dstCoord = self.coord.apply_delta(delta)
          dstPiece = self.board.piece_at_coord(dstCoord)
          !dstPiece.nil? && dstPiece.direction != srcDirection
        end
      end

      def move_forward
        [{x: 0, y: srcDirection}].select do |delta|
          dstCoord = self.coord.apply_delta(delta)
          dstPiece = self.board.piece_at_coord(dstCoord)
          dstPiece.nil?
        end
      end
    end
  end
end
