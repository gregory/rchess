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
      piece = self.piece_at_coord(coord)
      piece.nil? ? nil : piece.color
    end

    def piece_at_coord(coord)
      piece_type = self.boxes[coord.y][coord.x]
      piece_type == EMPTY_BOX ? nil : Piece.new({type: piece_type, coord: coord})
    end

    def valid_path?(srcCoord, dstCoord)
      piece = piece_at_coord(srcCoord)

      return false unless piece
      path = piece_at_coord(srcCoord).path_to_coord(dstCoord)
      return false if path.empty?
      free_path?(path)
    end

    def free_path?(path)
      tmp_path = path.dup
      tmp_path.pop #the destination can be occupied
      !tmp_path.any?{ |coord| piece_at_coord(Coord.new(coord)) != nil }
    end
  end
end
