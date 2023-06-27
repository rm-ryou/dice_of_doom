module DiceOfDoom
  class Computer < DefaultPlayer
    include AI

    def turn_execution(state)
      return super(state) if state.player == 0
      ratings = ab_get_ratings_max(limit_tree_depth(node), node.player, Float::INFINITY, -1 * Float::INFINITY)
      state = state.child[ratings.index(ratings.max)]
    end
  end
end
