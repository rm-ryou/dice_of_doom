module DiceWars
  class Node
    attr_accessor :data, :child

    # nodeではdataが与えられてそれをchildに入れることしかしない
    # dataしかしらない
    def initialize(data)
      @data   = data
      @child  = []
    end

    def add_child(node)
      @child.push(node)
    end

  end
end
