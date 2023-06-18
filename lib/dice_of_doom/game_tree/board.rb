module DiceOfDoom
  module GameTree
    module Board

      def add_new_dice(state, is_territory, spare_dice)
        loop do
          before_spare_dice = spare_dice
          state.board.each do |ary|
            next unless is_territory.call(ary[0])
            if ary[1] < ::MAX_DICE && spare_dice > 0
              ary[1] += 1
              spare_dice -= 1
            end
          end
          break if spare_dice <= 0 || spare_dice == before_spare_dice
        end
      end

      def neighbors(pos)
        up   = pos - ::BOARD_SIZE
        down = pos + ::BOARD_SIZE
        table = [up, down]
        table << up - 1 << pos - 1    unless pos % ::BOARD_SIZE == 0
        table << pos + 1 << down + 1  unless (pos + 1) % ::BOARD_SIZE == 0
        table.map.select { |num| num >= 0 && num < ::BOARD_HEXNUM }
      end

      def board_attack(board, player, src, dst, dice)
        # FIXME
        board.map.with_index do |ary, idx|
          ary = new_grid(player, 1)         if idx == src
          ary = new_grid(player, dice - 1)  if idx == dst
          ary
        end
      end

      def dup_board(board)
        new_board = gen_array
        board.each.with_index do |ary, idx|
          new_board[idx] = ary.dup
        end
        new_board
      end

      def player(pos)
        p @board
        puts "self = #{self}"
        # self[pos][0]
      end

      def gen_board
        gen_array.map.with_index { |elt, idx| elt = [idx < ::NUM_PLAYERS ? 0 : 1, gen_random_num] }
      end

      def gen_array
        Array.new(::BOARD_SIZE * ::BOARD_SIZE) { Array.new(::NUM_PLAYERS, 0) }
      end

      def gen_random_num
        Random.new.rand(1..::MAX_DICE)
      end

      def new_grid(player, dice)
        [player, dice]
      end
    end
  end
end
