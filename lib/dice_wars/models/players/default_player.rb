module DiceWars
  class DefaultPlayer

    def letter(num)
      (num + 97).send(:chr)
    end

    def handle(node, moves)
      str = "choose your move:\n"
      i = 0
      unless node.first_move?
        str += "#{i + 1}. end turn\n"
        i += 1
      end
      while moves[i]
        str += "#{i + 1}. #{moves[i].attack_lst[0]} -> #{moves[i].attack_lst[1]}\n" if moves[i].attack_lst
        i += 1
      end
      str
    end
  end
end

