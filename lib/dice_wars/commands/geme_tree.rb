module DiceWars
  class GameTree

    def initialize(node = nil)
      @game_tree = Tree.new
      @cur_node = @game_tree.root = if !node
                                      Node.new(Board.gen_board, 0)
                                    else
                                      Node.new(node.board,
                                               node.player,
                                               node.spare,
                                               node.first_move,
                                               node.moves)
                                    end
      p @cur_node.board
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
