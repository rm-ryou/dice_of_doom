module DiceWars
  class Command

    def initialize(player)
      @cur_node = ::DiceWars::GameTree.new.next_moves
      @player   = player
      print_info
    end

    def print_info
      puts "current player = #{@player.letter(@cur_node.player)}"
      puts @cur_node.board.draw_board(@player)
    end

    def announce_winner
      num_of_player_occupied = winners
      if num_of_player_occupied.size == 1
        puts "The winner is #{@player.letter(num_of_player_occupied.first)}"
      else
        print "The winner is a tie between"
        num_of_player_occupied.size.times do |i|
          print "#{@player.letter(i)}, "
        end
        puts
      end
    end

    def winners
      num_occupied_player = Array.new(::NUM_PLAYERS, 0)
      (0 ... ::BOARD_HEXNUM).each do |i|
        num_occupied_player[@cur_node.board.player(i)] += 1
      end
      num_occupied_player.each_index.select { |i| num_occupied_player[i] == num_occupied_player.max }
    end
  end
end
