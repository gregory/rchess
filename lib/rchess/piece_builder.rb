module Rchess
  class PieceBuilder
    PIECES ={
      p: 'pawn',
      b: 'bishop',
      q: 'queen',
      c: 'knight',
      r: 'rook',
      k: 'king'
    }

    def self.build_piece(box, board)
      piece = Rchess::Piece.new(box, board)

      case box.host.downcase
      when :p
        PawnMove.new(piece)
      else
        binding.pry
      #when :c
        #KnightMove.new(piece)
      #when :r
        #RookMove.new(piece)
      #when :b
        #BishopMove.new(piece)
      #when :q
        #BishopMove.new(RookMove.new(piece))
      #when :k
        #BishopMove.new(RookMove.new(piece, 1), 1)
      end
    end
  end
end
