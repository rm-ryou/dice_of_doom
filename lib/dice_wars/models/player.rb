module DiceWars
  class Player

    def letter(num)
      (num + 97).send(:chr)
    end
  end
end
