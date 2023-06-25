module DiceWars
  class Node
    attr_reader :board, :player, :spare, :child

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
      @child      = []
    end

    def add_child(node)
      @child.push(node)
    end

    def first_move?
      @first_move
    end
  end
end
