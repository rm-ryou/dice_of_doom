module DiceWars
  class Moves
    attr_accessor :first_move, :moves

    def initialize(first_move = true)
      @first_move = first_move
      @moves      = []
    end

    def first_move?
      @first_move
    end
  end
end
