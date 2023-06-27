module DiceOfDoom
  class Command

    def initialize(player)
      @cur_state  = GameTree.new.next_moves
      @player     = player
    end

    def play_vs_computer
      loop do
        print_info
        return announce_winner if @cur_state.child.empty?
        puts @player.turn_execution(@cur_state)
        @cur_state = next_state(input_number)
      end
    end

    def print_info
      puts "current player = #{@player.letter(@cur_state.player)}"
      puts @cur_state.board.draw_board(@player)
    end

    def is_num?(input)
      true if Integer(input) rescue false
    end

    def input_number
      loop do
        num = STDIN.gets
        if is_num?(num)
          num = num.to_i - 1
          return num if num >= 0 && num < @cur_state.child.size
        end
        puts "invalid input."
      end
    end

    def next_state(num)
      ::DiceOfDoom::GameTree.new(@cur_state.child[num]).next_moves
    end

  end
end
