module Rchess
  class Coord
    attr_accessor :x, :y

    def initialize(h)
      self.x = h.fetch(:x){ raise ArgumentError.new("Please provide a value for key :x") }
      self.y = h.fetch(:y){ raise ArgumentError.new("Please provide a value for key :y") }
    end

    def apply_delta(delta)
      Coord.new({ x: (self.x + delta[:x]), y: (self.y + delta[:y]) })
    end
  end
end
