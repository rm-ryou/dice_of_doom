module DiceWars
  class Node
    attr_accessor :board, :player, :spare
    # attr_accessor :data, :child

    # nodeではdataが与えられてそれをchildに入れることしかしない
    # dataしかしらない
    # def initialize(data)
    #   @data   = data
    #   @child  = []
    # end

    def initialize(board, player, spare = 0, first_move = true, moves = [])
      @board      = board
      @player     = player
      @spare      = spare
      @first_move = first_move
      @moves      = moves
    end

    def add_child(node)
      @child.push(node)
    end

  end
end
