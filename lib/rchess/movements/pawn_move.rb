module Rchess
  class PawnMove < Move
    def available_destinations
      super + move_forward + take_piece
    end

    private

    def move_forward
      [
        Box.from_coord_to_pos(coord[:x], coord[:y]+1)
      ]
    end

    def take_piece
      positions = [
        Box.from_coord_to_pos(coord[:x]+1, coord[:y]+1),
        Box.from_coord_to_pos(coord[:x]-1, coord[:y]+1)
      ]

      positions.select do |p|
        col = board.color_for_piece_at(p)
        board.pos_is_in_board?(p) && !col.nil? && col != piece.color
      end
    end
  end
end
