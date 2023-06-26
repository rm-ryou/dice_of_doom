module DiceOfDoom
  class GameTree

    def initialize(node = nil)
      @game_tree = if !node
                     Node.new(Board.new, 0)
                   else
                     Node.new(node.board,
                              node.player,
                              node.spare,
                              node.first_move,
                              node.attack_lst)
                   end


      @game_tree.spare = 3
      p @game_tree.board.grids
      @game_tree.board.add_new_dice(@game_tree.player, @game_tree.spare)
      p @game_tree.board.grids
    end

    def add_passing_move(moves)
      return moves if @game_tree.first_move?

      @game_tree.board.add_new_dice
      moves.unshift(Node.new(@game_tree.board, (@game_tree.player + 1) % ::NUM_PLAYERS))
    end

    def attacking_moves
    end

  end
end
