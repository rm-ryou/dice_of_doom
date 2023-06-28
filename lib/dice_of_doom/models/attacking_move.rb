module DiceOfDoom
  class AttackingMove
    attr_reader :src_index, :dst_index, :attacker

    def initialize(src_index, dst_index, attacker)
      @src_index = src_index
      @dst_index = dst_index
      @attacker  = attacker
    end

    def list
      [@src_index, @dst_index]
    end
  end
end
