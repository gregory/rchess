module Rchess
  class Game
    include Wisper::Publisher
    COLORS = [:white, :black]

    attr_accessor :board
    attr_reader :players, :turn

    def initialize
      @turn = :white
      @board = BoardBuilder.new_board
    end

    def add_player(player, color)
      #TODO: validate that the color has not been picked
      raise ArgumentError.new("Unknown color - Choose among: #{COLORS.join(', ')}") unless COLORS.include? color

      players[player.uuid] = {color: color, player: player, chess: false}
    end

    def player_moved(player, fromPos, toPos)
      publish(:no_move)                  unless fromPos != toPos
      publish(:you_are_frozen)           unless self.player_can_play?(player)
      publish(:you_dont_own_the_piece)   unless self.player_own_box?(player, fromPos)

      board.on(:cant_reach_box){ publish(:cant_reach_box)}
      board.on(:unreachable_destination){publish(:unreachable_destination)}
      board.on(:moved) do |board|
        @turn = @turn == :white ? :black : :white
      end
      board.move(fromPos, toPos)
    end

    def players
      @players ||= Hash.new{ false }
    end

    def board
      @board ||= Board.new
    end

    def player_can_play?(player)
      self.players[player.uuid][:color] == self.turn
    end

    def player_own_box?(player, pos)
      self.board.color_for_piece_at(pos) == players[player.uuid][:color]
    end
  end
end
