module Rchess
  class Board
    BOUDARIES = (0..8)
    COLORS = {
      white: :downcase,
      black: :upcase
    }

    attr_accessor :boxes

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

    def move(fromBox, toBox)

    end
  end
end
