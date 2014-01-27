module Rchess
  class Destinations
    #def initialize(params)
      #@board    = params.fetch(:board)
      #@srcCoord = params.fetch(:srcCoord)
    #end

    #def threaten_by_color?(color)
      #paths_type_mapping.each do |type, paths|
        #paths.map(&:destinations).flatten.any? do |coordH|
          #dst = @board.piece_at_coord(Coord.new(coordH))

          ##if there is a piece, with the type corresponding to the path, and a different color
          #!dst.nil? && dst.type.downcase == type && dst.color != color
        #end
      #end
    #end

    #def destinations_for_type(type)
      #paths_type_mapping[:type].map(&:destinations).flatten(1)
    #end

    #private

    #def paths_type_mapping
      ##TODO: find a way not to load all those objects
      #{
        #p: [Paths::Pawn.new({srcCoord: @srcCoord, board: @board})],
        #b: [Paths::Bishop.new({srcCoord: @srcCoord, board: @board})],
        #q: [Paths::Bishop.new({srcCoord: @srcCoord, board: @board}), Paths::Rook.new({srcCoord: @srcCoord, board: @board})].flatten(1),
        #c: [Paths::Knight.new({srcCoord: @srcCoord, board: @board})],
        #r: [Paths::Rook.new({srcCoord: @srcCoord, board: @board})],
        #k: [Paths::Bishop.new({srcCoord: @srcCoord, board: @board}, 1), Paths::Rook.new({srcCoord: @srcCoord, board: @board}, 1)].flatten(1)
      #}
    #end
  end
end
