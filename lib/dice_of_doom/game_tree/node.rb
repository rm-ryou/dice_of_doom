module DiceOfDoom
  module GameTree
    class Node
      attr_accessor :value, :child

      def initialize(value)
        self.value = value
        self.child = []
      end

      def add_child(value)
        self.child.push(Node.new(value))
      end
    end
  end
end
