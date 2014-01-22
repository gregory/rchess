module Rchess
  class Board
    attr_accessor :boxes

    def initialize
      self.boxes = []

      (0..7).each do |x|
        self.boxes << (0..7).map{ |y| Box.new(Integer("#{y}#{x}",10)) }
      end
    end
  end
end
