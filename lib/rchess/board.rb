module Rchess
  class Board
    include Wisper::Publisher

    BOUDARIES = (0...8)
    EMPTY_BOX = ""

    attr_accessor :boxes

    def boxes
      @boxes ||= Array.new(BOUDARIES.count){ Array.new(BOUDARIES.count){ EMPTY_BOX }}
    end
  end
end
