module Rchess
  class Coord
    attr_accessor :x, :y

    def initialize(h)
      self.x = h.fetch(:x){ raise ArgumentError.new("Please provide a value for key :x") }
      self.y = h.fetch(:y){ raise ArgumentError.new("Please provide a value for key :y") }
    end

    def self.from_i(i)
      { y: i/10, x: i%10 }
    end

    def to_i
      Integer("#{y.abs}#{x.abs}")
    end
  end
end
