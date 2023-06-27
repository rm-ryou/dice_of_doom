module DiceOfDoom
  class Command

    def initialize(player = nil)
      @cur_state  = GameTree.new.next_moves
      @player     = player
    end

    def play_vs_computer
      loop do
        print_info
        return announce_winner if @cur_state.child.empty?
        @player.turn_execution(@cur_node)
      end
    end

    def print_info
      puts "current player = #{@player.letter(@cur_node.player)}"
      puts @cur_node.board.draw_board(@player)
    end
  end
end
