module Rchess
  class BoardBuilder
    def self.new_board
      Board.new.tap do |board|
        paint_pieces(place_pieces(create_boxes(board)))
      end
    end

    private

    def self.create_boxes(board)
      board.boxes = []
      (0..7).each do |y|
        board.boxes << (0..7).map{ |x| board.box_from_coord(x, y) }
      end

      board
    end

    def self.paint_pieces(board)
      (board.boxes[-1] + board.boxes[-2]).each{|box| box.host = box.host.upcase}

      board
    end

    def self.place_pieces(board)
      below_line = board.boxes[0]
      above_line = board.boxes[-1]

      pieces = Rchess::PieceBuilder::PIECES.invert

      below_line[0].host = below_line[-1].host = above_line[0].host = above_line[-1].host = pieces['rook']
      below_line[1].host = below_line[-2].host = above_line[1].host = above_line[-2].host = pieces['knight']
      below_line[2].host = below_line[-3].host = above_line[2].host = above_line[-3].host = pieces['bishop']

      below_line[3].host = above_line[3].host = pieces['queen']
      below_line[4].host = above_line[4].host = pieces['king']

      (board.boxes[1] + board.boxes[-2]).each do |box|
        box.host = pieces['pawn']
      end

      board
    end
  end
end
