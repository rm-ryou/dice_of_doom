module DiceOfDoom
  module AI
    AI_LEVEL = 4

    def limit_tree_depth(node, depth = AI_LEVEL)
      return if depth == 1

      node.child.each do |new_parent|
        new_parent.add_child(::DiceOfDoom::GameTree.new(new_parent).next_nodes.child)
        limit_tree_depth(new_parent, depth - 1)
      end
      node
    end

    def score_board(node)
      sum = 0
      (0 ... ::BOARD_HEXNUM).each do |i|
        sum += if node.board.player_of(node.board.grids[i]) == node.situation.id
                 -1
               elsif threatened(i, node.board)
                 2
               else
                 1
               end
      end
      sum
    end

    def threatened(pos, board)
      board.neighbors_of(pos).each do |neighbor|
        return true if board.attacable?(neighbor, pos)
      end
      false
    end

    def ab_get_ratings_max(node, player, upper_limit, lower_limit)
      node.child.map do |next_node|
        x = ab_rate_position(next_node, player, upper_limit, lower_limit)
        return x if x >= upper_limit
        x > lower_limit ? x : lower_limit
      end
    end

    def ab_get_ratings_min(node, player, upper_limit, lower_limit)
      node.child.map do |next_node|
        x = ab_rate_position(next_node, player, upper_limit, lower_limit)
        return x if x <= lower_limit
        x > upper_limit ? upper_limit : x
      end
    end

    def ab_rate_position(tree, player, upper_limit, lower_limit)
      return score_board(tree) if tree.child.empty?
      if tree.situation.id == player
        ab_get_ratings_max(tree, player, upper_limit, lower_limit).max
      else
        ab_get_ratings_min(tree, player, upper_limit, lower_limit).min
      end
    end

  end
end
