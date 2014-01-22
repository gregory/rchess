module Rchess
  class Board
    include Wisper::Publisher

    BOUDARIES = (0..8)
    COLORS = {
      white: :downcase,
      black: :upcase
    }

    attr_accessor :boxes

    def color_for_piece_at(pos)
      box = box_at_pos(pos)
      return nil if box.nil?
      host = box.host
      return nil if host.nil?
      COLORS.detect{|k,v| host.send(v) == host}.first
    end

    def pos_is_in_board?(pos)
      coord = Box.from_pos_to_coord(pos)
      BOUDARIES.include?(coord[:x]) && BOUDARIES.include?(coord[:y])
    end

    def box_at_pos(pos)
      self.boxes.flatten.detect{|box| box.pos == pos }
    end

    def box_from_coord(x, y)
      build_box_from_pos(Box.from_coord_to_pos(x, y))
    end

    def build_box_from_pos(pos)
      Box.new(pos).tap do |box|
        coord = box.to_coord
        x, y  = coord[:x], coord[:y]
        raise ArgumentError.new("Box out of the board") unless BOUDARIES.include?(x) && BOUDARIES.include?(y)
      end
    end

    def move(fromPos, toPos)
      publish(:cant_reach_box) unless available_positions_from(fromPos).include? toPos

      fromBox = box_at_pos(fromPos)

      piece = PieceBuilder.build_piece(fromBox, self)

      if piece.available_destinations.include? toPos
        toBox = box_at_pos(toPos)

        toBox.host, fromBox.host = fromBox.host, toBox.host
        publish(:moved, self)
      else
        publish(:unreachable_destination)
      end
    end

    private

    def available_positions_from(fromPos)
      player_color = color_for_piece_at(fromPos)
      boxes.flatten.select do |box|
        box.host.nil? || box.host != box.host.send(COLORS[player_color])
      end
    end
  end
end
