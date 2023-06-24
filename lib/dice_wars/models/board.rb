module DiceWars
  class Board
    attr_accessor :board

    def initialize(board)
      @board = board
    end

    class << self
      def gen_board
        gen_array.map { |ary| ary = [Board.gen_random_player, Board.gen_random_dice] }
      end

      def gen_array
        Array.new(::BOARD_HEXNUM) { Array.new(::NUM_PLAYERS, 0) }
      end

      def gen_random_player
        Random.new.rand(1 .. ::MAX_DICE)
      end

      def gen_random_dice
        Random.new.rand(0 .. 1)
      end
    end
  end
end
