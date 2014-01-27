module Rchess
  class BoardBuilder
    def self.build
      Board.new.tap do |board|
        self.paint_pieces(self.place_pieces(board))
      end
    end

    private

    def self.paint_pieces(board)
      #lower lines are white and go up

      [board.boxes[-1], board.boxes[-2]].each do |line|
        line.each_with_index{ |box,i| line[i] = box.send(Piece::COLORS[:white]) }
      end

      [board.boxes[0], board.boxes[1]].each do |line|
        line.each_with_index{ |box,i| line[i] = box.send(Piece::COLORS[:black]) }
      end

      board
    end

    def self.place_pieces(board)
      top_line    = board.boxes[0]
      bottom_line = board.boxes[-1]

      bottom_line[0] = bottom_line[-1] = top_line[0] = top_line[-1] = :r
      bottom_line[1] = bottom_line[-2] = top_line[1] = top_line[-2] = :c
      bottom_line[2] = bottom_line[-3] = top_line[2] = top_line[-3] = :b

      bottom_line[3] = top_line[3] = :q
      bottom_line[4] = top_line[4] = :k

      [board.boxes[1],  board.boxes[-2]].each do |line|
        line.each_with_index{ |_,i| line[i] = :p }
      end

      board
    end
  end
end
