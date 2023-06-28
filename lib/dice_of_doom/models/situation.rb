module DiceOfDoom
  class Situation
    attr_reader :id, :spare_dice, :first_move

    def initialize(id, spare_dice = 0, first_move = true)
      @id           = id
      @spare_dice   = spare_dice
      @first_move   = first_move
    end

    def next_id
      (id + 1) % ::NUM_PLAYERS
    end

  end
end
