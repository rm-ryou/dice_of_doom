module DiceWars
  class State
    attr_accessor :player, :board, :moves

    def initialize(player, board, moves, spare)
      @player = player
      @board  = board
      @moves  = moves
      @spare  = spare
    end

    def first_move?
      # これだとmovesが何を持っているのか詳しく知ってしまっている
      # self.moves.first_move
      self.moves.first_move?
    end
  end
end
