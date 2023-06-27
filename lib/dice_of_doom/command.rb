module DiceOfDoom
  class Command

    def initialize
      @cur_state = GameTree.new.next_moves
      p @cur_state
    end
  end
end
