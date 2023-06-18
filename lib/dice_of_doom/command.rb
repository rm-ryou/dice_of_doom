module DiceOfDoom
  class Command

    def initialize
      @game_tree = ::DiceOfDoom::GameTree::Game.new.tree
      @cur_node = @game_tree
      player2human
    end

    def player2human
      print_info
      if @game_tree.child.empty?
        return announce_winner
      else
        handle_human
      end
      player2human
    end

    def print_info
      puts "current player = #{(@cur_node.player + 97).send(:chr)}"
      puts draw_board
    end

    def draw_board
      str = ''
      ::BOARD_SIZE.times do |y|
        str += "  " * (::BOARD_SIZE - y - 1)
        ::BOARD_SIZE.times do |x|
          id = ::BOARD_SIZE * y + x
          str += "#{(@cur_node.board[id][0] + 97).send(:chr)}-#{@cur_node.board[id][1]} "
        end
        str += "\n"
      end
      str
    end

    def handle_human
      puts "choose your move:"
      moves = @cur_node.child
      p "moves.size = #{moves.size}"
      moves.each.with_index(1) do |move, i|
        print "#{i} "
        puts "#{move.attack_lst[0]} -> #{move.attack_lst[1]}"
      end
      num = gets.to_i
      @cur_node = moves[num - 1]

    end

    def announce_winner
      puts "game is end"
    end
  end
end
