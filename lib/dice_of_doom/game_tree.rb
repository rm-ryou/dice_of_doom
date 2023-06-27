module DiceOfDoom
  class GameTree

    def initialize(node = nil)
      board = [[1, 1], [1, 1], [0, 2],
               [0, 1], [0, 3], [0, 2],
               [1, 2], [1, 3], [0, 3]]
      @cur_node = if !node
                    # Node.new(Board.new, 0)
                    Node.new(Board.new(board), 0)
                  else
                    Node.new(node.board,
                             node.player,
                             node.spare,
                             node.first_move,
                             node.attack_lst)
                  end
    end

    def next_moves
      @cur_node.add_child(add_passing_move(attacking_moves))
      @cur_node
    end

    private

    def add_passing_move(moves)
      return moves if @cur_node.first_move?

      @cur_node.board.add_new_dice(@cur_node.player, @cur_node.spare - 1)
      moves.unshift(Node.new(@cur_node.board, (@cur_node.player + 1) % ::NUM_PLAYERS))
    end

    def attacking_moves
      @cur_node.board.attacking_moves(@cur_node.player).map do |attacking_move|
        attacked_board = @cur_node.board.apply_attacking_move(attacking_move)
        Node.new(Board.new(attacked_board), @cur_node.player, @cur_node.spare + @cur_node.board.dice_of(attacking_move.dst_index), false, attacking_move.list)
      end
    end

  end
end
