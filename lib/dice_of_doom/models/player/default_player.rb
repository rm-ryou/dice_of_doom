module DiceOfDoom
  module Player
    class DefaultPlayer

      def letter(num)
        (num + 97).send(:chr)
      end

      def turn_execution(state)
        str = "choose your move:\n"
        state.child.each.with_index do |next_state, index|
          str += if next_state.attack_move.empty?
                   "#{index + 1}. end turn\n"
                 else
                   "#{index + 1}. #{next_state.attack_move[0]} -> #{next_state.attack_move[1]}\n"
                 end
        end
        str
      end

    end
  end
end
