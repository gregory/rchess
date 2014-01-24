module Rchess
  class RookMove < Move
    def initialize(piece,power=7)
      @power = power
      super(piece)
    end

    def available_destinations
      super + horiz_moves + vertic_moves
    end

    private

    def horiz_moves
      (1..@power).map do |i|
        [
          Box.from_coord_to_pos(coord[:x]+1*i, coord[:y]),
          Box.from_coord_to_pos(coord[:x]-1*i, coord[:y]),
        ]
      end.flatten
    end

    def vertic_moves
      (1..@power).map do |i|
        [
          Box.from_coord_to_pos(coord[:x], coord[:y]+1*i),
          Box.from_coord_to_pos(coord[:x], coord[:y]-1*i),
        ]
      end.flatten
    end
  end
end
