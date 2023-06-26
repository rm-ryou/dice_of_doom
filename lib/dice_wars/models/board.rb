# boardのロジック多すぎる

module DiceWars
  class Board < Array
    attr_accessor :board

    def initialize(grids = nil)
      # boardから次のては生成できる＝＞いらない
      #      ""  diceの数がわから＝＞いらない
      # @board = board
      # ↓単数系の複数形にするクラス名とインスタンス名の重複はナンセンス
      @grids = grids ? grids : Board.gen_grids
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

    def player_of(grid)
      grid[0]
    end
    private :player_of


    def dice_of(grid)
      grid[1]
    end
    private :dice_of

    def add_new_dice(cur_player, spare_dice)
      num_before_allocating = spare_dice
      while spare_dice <= 0 || spare_dice == num_before_allocating
        @grids = @grids.map do |grid|
          next grid unless player_of(grid) == cur_player && spare_dice > 0
          # player_of(grid)
          # dice_of(grid)  # gridのdice
          spare_dice -= 1
          [player_of(grid), dice_of(grid) + 1]
        end
        # (0 ... ::BOARD_HEXNUM).each do |i|
        #   next unless player(i) == cur_player
        #   if dice(i) < ::MAX_DICE && spare_dice > 0
        #     @board[i][1] += 1
        #     spare_dice -= 1
        #   end
        # end
        num_before_allocating = spare_dice
      end
      # loop do
      #   num_before_allocating = spare_dice
      #   (0 ... ::BOARD_HEXNUM).each do |i|
      #     next unless player(i) == cur_player
      #     if dice(i) < ::MAX_DICE && spare_dice > 0
      #       @board[i][1] += 1
      #       spare_dice -= 1
      #     end
      #   end
      #   break if spare_dice <= 0 || spare_dice == num_before_allocating
      # end
    end

    def apply_attacking_move(move)
      # attack(@board, @board.player(move.src_index), move.src_index, move.dst_index, @board.dice(move.src_index))
      attack(@board, move.attacker, move.src_index, move.dst_index, @board.dice(move.src_index))
      # moveにattackerを追加
      @board.map.with_index do |grid, idx
    end
    # 基本インスタンス変数は渡さない

    # 単にattackableなboardの配列を返すのみ
    # def attackable(cur_player)
    def attacking_moves(cur_player)
      moves       = []
      dices       = []
      attack_lst  = []
      (0 ... ::BOARD_HEXNUM).each do |src|
        next if player(src) != cur_player
        neighbors(src).each do |neighbor|
          if player(neighbor) != player(src) && dice(src) > dice(neighbor)
            attack_lst << AttackingMove.new(src, neighbor)
            # dices      << dice(neighbor)
            # moves      << attack(dup_board, cur_player, src, neighbor, dice(src))
            # attack_lst << [src, neighbor]  # リストだとマジックナンバー化する→クラス化を行う
          end
        end
      end
      attack_lst
      # return moves, dices, attack_lst
      # moves -> 攻撃後の盤面を入れた配列
      # dices -> 攻撃した時に取得するダイスの数
      # attack+lst -> 攻撃の手
    end
    # attackable->攻撃可能 clientはこれを呼び出した時に攻撃可能かどうかの返り値を期待する。＝＞メソッド名と返り値が一致しない
    # 極端attack_lstがあればmoves, dicesは生成できる＝＞情報の重複

    # attackable(攻撃のての配列を取得).attack_and_collect_next_board(attackableの配列をイテレータを使用して実際に攻撃)

    # attacking_moveをクラス化

    def attack(player, src, dst)
      @board.map.with_index do |ary, idx|
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

    def draw_board(cur_player)
      str = ''
      ::BOARD_SIZE.times do |y|
        str += "  " * (::BOARD_SIZE - y - 1)
        ::BOARD_SIZE.times do |x|
          id = ::BOARD_SIZE * y + x
          str += "#{cur_player.letter(player(id))}-#{dice(id)} "
        end
        str += "\n"
      end
      str
    end

    class << self
      def gen_board
        gen_array.map { |ary| ary = [Board.gen_random_player, Board.gen_random_dice] }
      end

      def gen_grids
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
