module DiceOfDoom
  class Node
    attr_reader :board, :situation, :attack_move

    def initialize(board, situation, attack_move = [])
      @board        = board
      @situation    = situation
      @attack_move  = attack_move
      @child        = []
    end

    def add_child(node)
      @child = node
    end

  end
end
