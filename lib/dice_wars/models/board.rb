# boardのロジック多すぎる

module DiceWars
  class Board < Array
    attr_accessor :board

    def initialize(board = Board.gen_board)
      @board = board
    end

    def cache_neighbors(pos, table)
      @memo_neighbors[pos] = table.map.sort.select { |num| num >= 0 && num < ::BOARD_HEXNUM }
      @memo_neighbors[pos]
    end

    def neighbors(pos)
      @memo_neighbors ||= {}
      return @memo_neighbors[pos] if @memo_neighbors.has_key?(pos)

      up    = pos - ::BOARD_SIZE
      down  = pos + ::BOARD_SIZE
      table = [up, down]
      table << up - 1 << pos - 1    unless pos % ::BOARD_SIZE == 0
      table << pos + 1 << down + 1  unless (pos + 1) % ::BOARD_SIZE == 0
      cache_neighbors(pos, table)
    end

    def add_new_dice(cur_player, spare_dice)
      loop do
        num_before_allocationg = spare_dice
        (0 ... ::BOARD_HEXNUM).each do |i|
          next unless player(i) == cur_player
          if dice(i) < ::MAX_DICE && spare_dice > 0
            @board[i][1] += 1
            spare_dice -= 1
          end
        end
        break if spare_dice <= 0 || spare_dice == num_before_allocating
      end
    end

    # 単にattackableなboardの配列を返すのみ
    def attackable(cur_player)
      moves       = []
      dices       = []
      attack_lst  = []
      (0 ... ::BOARD_HEXNUM).each do |src|
        next if player(src) != cur_player
        neighbors(src).each do |neighbor|
          if player(neighbor) != player(src) && dice(src) > dice(neighbor)
            moves      << attack(dup_board, cur_player, src, neighbor, dice(src))
            dices      << dice(src)
            attack_lst << [src, neighbor]
          end
        end
      end
      return moves, dices, attack_lst
    end

    def attack(board, player, src, dst, dice)
      board.map.with_index do |ary, idx|
        next [player, 1]        if idx == src
        next [player, dice - 1] if idx == dst
        ary
      end
    end

    def player(idx)
      @board[idx][0]
    end

    def dice(idx)
      @board[idx][1]
    end

    # @boardをdupしたいからインスタンスメソッド
    def dup_board
      new_board = Board.gen_array
      @board.each.with_index do |ary, idx|
        new_board[idx] = ary.dup
      end
      new_board
    end

    class << self
      def gen_board
        gen_array.map { |ary| ary = [Board.gen_random_player, Board.gen_random_dice] }
      end

      def gen_array
        Array.new(::BOARD_HEXNUM) { Array.new(::NUM_PLAYERS, 0) }
      end

      def gen_random_dice
        Random.new.rand(1 .. ::MAX_DICE)
      end

      def gen_random_player
        Random.new.rand(0 .. 1)
      end
    end
  end
end
