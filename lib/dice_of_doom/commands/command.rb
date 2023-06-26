module DiceWars
  class Command

    def initialize(player)
      @cur_node = ::DiceWars::GameTree.new.next_moves
      @player   = player
    end

    def play_vs_computer
      loop do
        print_info
        return announce_winner if @cur_node.child.empty?
        determination_human_or_computer
      end
    end

    def determination_human_or_computer
      return @cur_node = @player.ab_handle(@cur_node) if @cur_node.player == 1
      puts @player.handle(@cur_node, @cur_node.child)
      @cur_node = next_node(input_number)
    end

    def is_num?(input)
      true if Integer(input) rescue false
    end

    def input_number
      loop do
        num = STDIN.gets
        if is_num?(num)
          num = num.to_i - 1
          break num if num >= 0 && num < @cur_node.child.size
          puts "invalid input."
        else
          puts "invalid input."
        end
      end
    end

    def next_node(num)
      ::DiceWars::GameTree.new(@cur_node.child[num]).next_moves
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
