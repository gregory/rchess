module Rchess
  class BishopMove < Move
    def initialize(power=7)
      @power = power
    end

    def available_destinations
      super + diags_moves
    end

    private

    def diags_moves
      (1..@power).map do |i|
        [
          Box.from_coord_to_pos(coord[:x]-1*i, coord[:y]+1*i),
          Box.from_coord_to_pos(coord[:x]+1*i, coord[:y]+1*i),
          Box.from_coord_to_pos(coord[:x]-1*i, coord[:y]-1*i),
          Box.from_coord_to_pos(coord[:x]+1*i, coord[:y]-1*i),
        ]
      end.flatten
    end
  end
end
