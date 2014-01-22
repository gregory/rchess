module Rchess
  class Box < Struct.new(:pos, :host)
    def self.from_pos_to_coord(pos)
      { y: pos/10, x: pos%10 }
    end

    def self.from_coord_to_pos(x, y)
      return -1 if x < 0 || y < 0
      Integer("#{y}#{x}", 10)
    end

    def to_coord
      Box.from_pos_to_coord(self.pos)
    end
  end
end
