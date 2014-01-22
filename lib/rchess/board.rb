module Rchess
  class Board
    attr_accessor :boxes

    def initialize
      self.boxes = []
      initialize_boxes
      initialize_pieces
    end

    private

    def initialize_boxes
      (0..7).each do |y|
        self.boxes << (0..7).map{ |x| Box.new(Integer("#{y}#{x}",10)) }
      end
    end

    def initialize_pieces
      below_line = self.boxes[0]
      above_line = self.boxes[-1]

      pieces = Rchess::PieceBuilder::PIECES.invert

      below_line[0].host = below_line[-1].host = above_line[0].host = above_line[-1].host = pieces['rook']
      below_line[1].host = below_line[-2].host = above_line[1].host = above_line[-2].host = pieces['knight']
      below_line[2].host = below_line[-3].host = above_line[2].host = above_line[-3].host = pieces['bishop']

      below_line[3].host = above_line[3].host = pieces['queen']
      below_line[4].host = above_line[4].host = pieces['king']

      (self.boxes[1] +self.boxes[-2]).each do |box|
        box.host = pieces['pawn']
      end
    end
  end
end
