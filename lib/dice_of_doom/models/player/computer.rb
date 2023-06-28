module DiceOfDoom
  module Player
    class Computer < DefaultPlayer
      include ::DiceOfDoom::AI

      def turn_execution(state)
        return super(state) if state.situation.id == 0
      end

      def max_ratings(state)
        ratings = ab_get_ratings_max(limit_tree_depth(state), state.situation.id, Float::INFINITY, -1 * Float::INFINITY)
        ratings.index(ratings.max)
      end
    end
  end
end
