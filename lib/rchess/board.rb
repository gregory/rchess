module Rchess
  class Board
    include Wisper::Publisher

    BOUDARIES = (0...8)
    EMPTY_BOX = ""

    attr_accessor :boxes

    def boxes
      @boxes ||= Array.new(BOUDARIES.count){ Array.new(BOUDARIES.count){ EMPTY_BOX }}
    end

    def coord_within_boundaries?(coord)
      BOUDARIES.include?(coord.x) && BOUDARIES.include?(coord.y)
    end

    def movement_within_board?(srcCoord, dstCoord)
      coord_within_boundaries?(srcCoord) || coord_within_boundaries?(dstCoord)
    end

    def piece_color_at_coord(coord)
      self.piece_at_coord(coord).color
    end

    def piece_at_coord(coord)
      piece_type = self.boxes[coord.y][coord.x]
      Piece.new({type: piece_type, coord: coord})
    end
  end
end
