module Rchess
  class Board
    include Wisper::Publisher

    BOUDARIES = (0...8)
    EMPTY_BOX = ""

    attr_reader :loosed_pieces
    attr_writer :boxes

    def initialize
      @boxes =[[:R, :C, :B, :Q, :K, :B, :C, :R],
               [:P, :P, :P, :P, :P, :P, :P, :P],
               ["", "", "", "", "", "", "", ""],
               ["", "", "", "", "", "", "", ""],
               ["", "", "", "", "", "", "", ""],
               ["", "", "", "", "", "", "", ""],
               [:p, :p, :p, :p, :p, :p, :p, :p],
               [:r, :c, :b, :q, :k, :b, :c, :r]]
    end

    def loosed_pieces
      @loosed_pieces ||= { white: [], black: [] }
    end

    def boxes
      @boxes ||= Array.new(BOUDARIES.count){ Array.new(BOUDARIES.count){ EMPTY_BOX }}
    end

    def movement_within_board?(srcCoord, dstCoord)
      coord_within_boundaries?(srcCoord) && coord_within_boundaries?(dstCoord)
    end

    def piece_at_coord(coord)
      box_at_coord(coord) == EMPTY_BOX ? nil : Piece.new({coord: coord, board: self})
    end

    def box_at_coord(coord)
      @boxes[coord.y][coord.x]
    end

    def move_src_to_dst!(srcCoord, dstCoord)
      srcPiece      = piece_at_coord(srcCoord)
      dstPiece      = piece_at_coord(dstCoord)
      src_box_value = dstPiece.nil? || dstPiece.color != srcPiece.color ? EMPTY_BOX : dstPiece.type # if diff color or nil we erase, else we swap

      @boxes[srcPiece.y][srcPiece.x], @boxes[dstCoord.y][dstCoord.x] = src_box_value, srcPiece.type
    end

    def valid_move?(piece, dstCoord)
      piece.can_goto_coord?(dstCoord) && !king_would_be_threatened?(piece, dstCoord)
    end

    def king_for_color(color)
      king_type  = Piece.type_to_color(:k, color) #TODO: make the type dynamic ~> piece::TYPES['king']
      king_index = self.boxes.flatten.index(king_type)
      king_coord = coord_from_index(king_index)

      Piece.new({coord: king_coord, board: self})
    end

    private

    def king_would_be_threatened?(piece, dstCoord)
      #simulate the next board
      next_board = Board.new
      #TODO: need a more efficient way of copying the values
      next_board.boxes = Marshal.load(Marshal.dump(@boxes))
      next_board.move_src_to_dst!(piece.coord, dstCoord)

      king = next_board.king_for_color(piece.color)
      king.is_threaten?
    end

    def coord_within_boundaries?(coord)
      BOUDARIES.include?(coord.x) && BOUDARIES.include?(coord.y)
    end

    def coord_from_index(index)
      width = BOUDARIES.count
      Coord.new({y: index/width, x: index%width})
    end
  end
end
