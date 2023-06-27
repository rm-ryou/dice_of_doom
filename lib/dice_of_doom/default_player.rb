module DiceOfDoom
  class DefaultPlayer

    def letter(num)
      (num + 97).send(:chr)
    end

    def turn_execution(state)
      str = "choose your move:\n"
      i = 0
      unless state.first_move?
        str += "#{i + 1}. end turn\n"
        i += 1
      end
      while state.child[i]
        str += "#{i + 1}. #{state.child[i].attack_lst[0]} -> #{state.child[i].attack_lst[1]}\n" if state.child[i].attack_lst?
        i += 1
      end
      str
    end
  end
end
