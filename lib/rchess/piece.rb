module Rchess
  class Piece
    attr_reader :box, :board, :color
    attr_accessor :destinations

    def initialize(box, board)
      @box = box
      @board = board
      @destinations = []
      @color = board.color_for_piece_at(box.pos)
    end
  end
end
