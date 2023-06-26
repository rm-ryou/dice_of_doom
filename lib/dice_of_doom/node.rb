module DiceOfDoom
  class Node
    attr_accessor :spare
    attr_reader :board, :player, :spare, :first_move, :attack_lst, :child

    def initialize(board, player, spare = 0, first_move = true, attack_lst = [])
      @board      = board
      @player     = player
      @spare      = spare
      @first_move = first_move
      @attack_lst = attack_lst
      @child      = []
    end

    def add_child(node)
      @child = node
    end

    def first_move?
      @first_move
    end
  end
end