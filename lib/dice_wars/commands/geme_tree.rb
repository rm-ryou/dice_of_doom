module DiceWars
  class GameTree

    def initialize(node = nil)
      @game_tree = @cur_node = if !node
                                 Node.new(Board.new(Board.gen_board), 0)
                               else
                                 Node.new(node.board,
                                          node.player,
                                          node.spare,
                                          node.first_move,
                                          node.moves)
                               end
      p @game_tree.board.board
      next_moves
    end

    def next_moves
      # @cur_node.child = add_passing_move(attacking_moves)
      @cur_node.add_child(add_passing_move(attacking_moves))
      @cur_node
    end

    def add_passing_move(moves)
      return moves if @cur_node.first_move?
      moves.unshift(@cur_node)
      moves.map do |move|
        add_new_dice(move, ->(player) { player == move.player }, move.spare - 1 )
        Node.new(move.board, (move.player + 1) % ::NUM_PLAYERS)
      end
    end

    def attacking_moves
      # 次に攻撃可能な配列を返す
      # DiceWars::Nodeのインスタンスの配列
      attackable_boards, dices, attack_lst = @cur_node.board.attackable(@cur_node.player)
      moves = []
      attackable_boards.size.times do |i|
        moves.push Node.new(attackable_boards[i], @cur_node.player, @cur_node.spare + dices[i], false, attack_lst[i])
      end
      moves
    end
  end
end
