module DiceOfDoom
  class Game

    def initialize(player)
      @cur_state = GameTree.new.next_nodes
      @player    = player
    end

    def play
      loop do
        print_info
        return puts announce_winner if @cur_state.child.empty?
        puts @player.turn_execution(@cur_state)
        @cur_state = if @cur_state.situation.id == 0 || @player.class == ::DiceOfDoom::Player::Human
                       next_state(input_number)
                     else
                       next_state(@player.max_ratings(@cur_state))
                     end
      end
    end

    def print_info
      puts "current player = #{@player.letter(@cur_state.situation.id)}"
      puts @cur_state.board.draw(@player)
    end

    def num?(input)
      true if Integer(input) rescue false
    end

    def input_number
      loop do
        num = STDIN.gets
        if num?(num)
          num = num.to_i - 1
          return num if num >= 0 && num < @cur_state.child.size
        end
        puts "invalid input."
      end
    end

    def next_state(num)
      ::DiceOfDoom::GameTree.new(@cur_state.child[num]).next_nodes
    end

    def announce_winner
      num_of_player_occupied = winners
      str = ''
      if num_of_player_occupied.size == 1
        str += "The winner is #{@player.letter(num_of_player_occupied.first)}"
      else
        str += "The winner is a tie between "
        num_of_player_occupied.size.times do |i|
          str += "#{@player.letter(i)}, "
        end
        str += "\n"
      end
      str
    end

    def winners
      num_of_player_occupied = Array.new(::NUM_PLAYERS, 0)
      (0 ... ::BOARD_HEXNUM).each do |i|
        num_of_player_occupied[@cur_state.board.player_of(@cur_state.board.grids[i])] += 1
      end
      num_of_player_occupied.each_index.select { |i| num_of_player_occupied[i] == num_of_player_occupied.max }
    end
      
  end
end
