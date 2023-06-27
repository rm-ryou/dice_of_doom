module DiceOfDoom
  class GameTree

    def initialize(node = nil)
      board = [[1, 1], [1, 1], [0, 2],
               [0, 1], [0, 3], [0, 2],
               [1, 2], [1, 3], [0, 3]]
      @game_tree = if !node
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
      add_passing_move(attacking_moves)
    end

    private

    def add_passing_move(moves)
      return moves if @game_tree.first_move?

      @game_tree.board.add_new_dice(@game_tree.player, @game_tree.spare - 1)
      moves.unshift(Node.new(@game_tree.board, (@game_tree.player + 1) % ::NUM_PLAYERS))
    end

    def attacking_moves
      @game_tree.board.attacking_moves(@game_tree.player).map do |attacking_move|
        attacked_board = @game_tree.board.apply_attacking_move(attacking_move)
        Node.new(Board.new(attacked_board), @game_tree.player, @game_tree.spare + @game_tree.board.dice_of(attacking_move.dst_index), false, attacking_move.list)
      end
    end

  end
end
