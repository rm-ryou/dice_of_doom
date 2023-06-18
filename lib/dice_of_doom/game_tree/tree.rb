module DiceOfDoom
  module GameTree
    class Tree
      attr_accessor :root

      def initialize
        self.root = nil
      end

      def show(node)
        return if node == nil

        # p node.class
        tmp = nil
        print("  ", node.board)
        node.child.size.times do |i|
          tmp = node.child[i]
          self.show(tmp)
        end
        # i = 0
        # tmp = nil
        # print("  ", node.value)
        # while (i < node.child.length)
        #   tmp = node.child[i]
        #   self.show(tmp)
        #   i += 1
        # end
      end
    end
  end
end
