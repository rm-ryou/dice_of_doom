module DiceWars
  class GameTree

    def initialize
      @game_tree = Tree.new
      @board = DiceWars::Board.new
      p @board.board

      @cur_node = @game_tree.root
    end

    def add_passing_move(moves)
      return moves if @cur_node.first_move?
      # end turnようのメソッドを作成し、
      # add_new_dice等を行う
    end

    def attacking_moves
    end
  end
end
