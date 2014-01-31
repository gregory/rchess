module Rchess
  class Game
    attr_accessor :board
    attr_reader :current_player_color, :loosed_pieces

    def initialize
      @current_player_color = Piece::WHITE_COLOR
      @loosed_pieces = {Piece::WHITE_COLOR => [], Piece::BLACK_COLOR =>  []}
    end

    def add_loosed_piece(dstPiece)
      self.loosed_pieces[dstPiece.color] << dstPiece.type
    end

    def move!(srcCoord, dstCoord)
      return false unless board.movement_within_board?(srcCoord, dstCoord)

      piece = board.piece_at_coord(srcCoord)
      return false unless piece
      return false unless current_player_own_piece?(piece)
      return false unless board.valid_move?(piece, dstCoord)

      dstPiece = board.piece_at_coord(dstCoord)
      add_loosed_piece(dstPiece) if dstPiece
      board.move_piece_to_coord!(piece, dstCoord)
      switch_current_player
      !checked?
    end

    def checked?
      false
      #king = board.king_for_color(current_player_color)
      #king.is_threaten?
    end

    def board
      @board ||= Board.new
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
