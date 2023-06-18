module DiceOfDoom
  class Command

    def initialize
      @game_tree = ::DiceOfDoom::GameTree::Game.new.tree
      @cur_node = @game_tree
      # @cur_node = @game_tree.child[0].child[0].child[0]
      # p @cur_node
      # tmp = @cur_node.child[0].child[0].child
      # p tmp.size
      # puts
      # tmp.each do |t|
      #   p tmp
      #   puts
      #   puts
      # end
      player2human
    end

    def player2human
      print_info
      if @cur_node.child.compact.empty?
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
      # p @cur_node.first_move
      i = 0
      # unless @cur_node.first_move?
      #   puts "#{i + 1}. end turn"
      #   i += 1
      # end
      while moves[i]
        # p "moves[#{i}] = #{moves[i]}"
        print "#{i + 1}. "
        puts "#{moves[i].attack_lst[0]} -> #{moves[i].attack_lst[1]}"
        i += 1
      end
      num = gets.to_i
      @cur_node = moves[num - 1]
    end

    def announce_winner
      puts "game is end"
    end
  end
end
