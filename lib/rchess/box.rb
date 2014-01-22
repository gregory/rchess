module Rchess
  class Box < Struct.new(:pos, :host)
    def to_coord
      { y: pos/10, x: pos%10 }
    end
  end
end
