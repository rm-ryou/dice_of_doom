module DiceOfDoom
  class GameTree

    def initialize(node = nil)
      board = [[1, 1], [1, 1], [0, 2],
               [0, 1], [0, 3], [0, 2],
               [1, 2], [1, 3], [0, 3]]
      @cur_node = if !node
                    Node.new(Board.new(board), Situation.new(0))
                  end
      p @cur_node.board.grids
      p add_passing_move(attacking_moves)
      p @cur_node.board.grids
    end

    private

    # １回目以降の攻撃なら相手のターンにする選択肢を追加
    def add_passing_move(moves)
      return moves if @cur_node.situation.first_move?

      @cur_node.board.add_new_dice(@cur_node.situation.id, @cur_node.situation.spare_dice - 1)
      moves.unshift(Node.new(Board.new(@cur_node.board), Situation.new(@cur_node.situation.next_id)))
    end

    # 次に攻撃可能な盤面の配列を取得
    def attacking_moves
      @cur_node.board.attacking_moves(@cur_node.situation.id).map do |attacking_move|
        attacked_board = @cur_node.board.apply_attacking_move(attacking_move)
        Node.new(Board.new(attacked_board), Situation.new(@cur_node.situation), attacking_move.list)
      end
    end
  end
end
