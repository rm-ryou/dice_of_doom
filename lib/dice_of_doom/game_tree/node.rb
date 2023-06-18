module DiceOfDoom
  module GameTree
    class Node
      attr_accessor :board, :player, :spare, :first_move, :attack_lst, :child

      def initialize(board, player, spare = 0, first_move = true)
        @board      = board
        @player     = player
        @spare      = spare
        @attack_lst = []
        @child      = []
      end

      # def add_child(board, player, spare, first_move)
      def add_child(node)
        # @child.push(Node.new(board, player, spare, first_move))
        @child.push(node)
      end

      def first_move?
        @first_move
      end
    end
  end
end
