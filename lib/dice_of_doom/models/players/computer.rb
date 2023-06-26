module DiceWars
  class Computer < DefaultPlayer
    include ::DiceWars::AI

    def ab_handle(node)
      return super(node, node.child) if node.player == 0
      ratings = ab_get_ratings_max(limit_tree_depth(node), node.player, 1 * (10 ** 10), -1 * (10 ** 10))
      node.child[ratings.index(ratings.max)]
    end
  end
end
