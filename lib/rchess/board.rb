module Rchess
  class Board
    include Wisper::Publisher

    BOUNDARIES = (0...8)
    EMPTY_BOX = ""

    attr_reader :loosed_pieces
    attr_accessor :boxes

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

    def movement_within_board?(srcCoord, dstCoord)
      coord_within_boundaries?(srcCoord) && coord_within_boundaries?(dstCoord)
    end

    def piece_at_coord(coord)
      box_at_coord(coord) == EMPTY_BOX ? nil : Piece.new({coord: coord, board: self})
    end

    def box_at_coord(coord)
      @boxes[coord.y][coord.x]
    end

    def valid_move?(piece, dstCoord)
      piece.can_goto_coord?(dstCoord) #&& !king_would_be_threatened?(piece, dstCoord)
    end

    def move_piece_to_coord!(piece, coord)
      dstPiece   = piece_at_coord(coord)
      dst_type = dstPiece.nil? || dstPiece.color != piece.color ? EMPTY_BOX : dstPiece.type # if diff color or nil we erase, else we swap

      @boxes[piece.y][piece.x], @boxes[coord.y][coord.x] = dst_type, piece.type
    end

    def coord_is_threatened_by_color?(target_coord, color)
      paths_from_target = Paths::Base.threaten_destinations_from_coord(target_coord, self)

      paths_from_target.flatten(1).any? do |coord|
        dstPiece = self.piece_at_coord(coord)
        dstPiece && dstPiece.color != color
      end
    end

    def coord_for_type_and_color(type, color)
      piece_type  = Piece.type_to_color(type, color) #TODO: make the type dynamic ~> piece::TYPES['king']
      piece_index = self.boxes.flatten.index(piece_type)
      coord_from_index(piece_index)
    end

    private

    def king_would_be_threatened?(piece, dstCoord)
      #simulate the next board
      next_board = Board.new
      #TODO: need a more efficient way of copying the values
      next_board.boxes = Marshal.load(Marshal.dump(@boxes))
      next_board.move_piece_to_coord!(piece, dstCoord)

      king_coord = coord_for_type_and_color(:k, piece.color)
      oponent_color = piece.color == Piece::WHITE_COLOR ? Piece::BLACK_COLOR : Piece::WHITE_COLOR
      coord_is_threatened_by_color?(king_coord, oponent_color)
    end

    def coord_within_boundaries?(coord)
      BOUNDARIES.include?(coord.x) && BOUNDARIES.include?(coord.y)
    end

    def coord_from_index(index)
      width = BOUNDARIES.count
      Coord.new({y: index/width, x: index%width})
    end
  end
end
