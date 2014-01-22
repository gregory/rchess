module Rchess
  class Board
    BOUDARIES = (0..8)
    COLORS = {
      white: :downcase,
      black: :upcase
    }

    attr_accessor :boxes

    def initialize
      self.boxes = []
      initialize_boxes
      initialize_pieces
      initialize_colors
    end

    def color_for_piece_at(atBox)
      host = box_at_pos(atBox.pos).host
      COLORS.detect{|k,v| host.send(v) == host}.first
    end

    def box_at_pos(pos)
      self.boxes.flatten.detect{|box| box.pos == pos }
    end

    def box_from_coord(x, y)
      box_from_pos(Integer("#{y}#{x}", 10))
    end

    def box_from_pos(pos)
      Box.new(pos).tap do |box|
        coord = box.to_coord
        x, y  = coord[:x], coord[:y]
        raise ArgumentError.new("Box out of the board") unless BOUDARIES.include?(x) && BOUDARIES.include?(y)
      end
    end

    private

    def initialize_boxes
      (0..7).each do |y|
        self.boxes << (0..7).map{ |x| box_from_coord(x, y) }
      end
    end

    def initialize_colors
      (self.boxes[-1] + self.boxes[-2]).each{|box| box.host = box.host.upcase}
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
