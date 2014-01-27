module Rchess
  class Game
    attr_accessor :board, :players
    attr_reader :current_player_color, :loosed_pieces

    def initialize(players)
      self.players          = players
      @current_player_color = Piece::WHITE_COLOR
      @loosed_pieces = {Piece::WHITE_COLOR => [], Piece::BLACK_COLOR =>  []}
    end

    def add_loosed_piece(dstPiece)
      self.loosed_pieces[dstPiece.color] << dstPiece.type
    end

    def players=(value)
      @players = {}
      player_white = value.fetch(:white){ raise ArgumentError.new("Please provide a white player")}
      player_black = value.fetch(:black){ raise ArgumentError.new("Please provide a black player")}

      @players[player_black.uuid] = { color: Piece::BLACK_COLOR, player: player_black }
      @players[player_white.uuid] = { color: Piece::WHITE_COLOR, player: player_white }
    end

    def move!(srcCoord, dstCoord)
      return false unless board.movement_within_board?(srcCoord, dstCoord)

      piece = board.piece_at_coord(srcCoord)
      return false unless piece
      return false unless current_player_own_piece?(piece)
      return false unless board.valid_move?(piece, dstCoord)

      dstPiece = board.piece_at_coord(dstCoord)
      add_loosed_piece(dstPiece) if dstPiece
      board.move_src_to_dst!(piece, dstCoord)
      switch_current_player
      true
    end

    def board
      @board ||= BoardBuilder.build
    end

    private

    def switch_current_player
      @current_player_color = @current_player_color == Piece::WHITE_COLOR ? Piece::BLACK_COLOR : Piece::WHITE_COLOR
    end

    def current_player_own_piece?(piece)
      current_player_color == piece.color
    end
  end
end
