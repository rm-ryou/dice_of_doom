module DiceOfDoom
  class Board
    attr_reader :grids

    class << self
      def gen_grids
        gen_array.map { |ary| ary = [gen_random_player, gen_random_dice] }
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

    def initialize(grids = nil)
      @grids = grids ? grids : Board.gen_grids
      @memo_neighbors ||= {}
    end

    def neighbors_of(mass)
      return @memo_neighbors[mass] if @memo_neighbors.has_key?(mass)

      up    = mass - ::BOARD_SIZE
      down  = mass + ::BOARD_SIZE
      neighbors = [up, down]
      neighbors  << up - 1    << mass - 1 unless mass        % ::BOARD_SIZE == 0
      neighbors  << mass + 1  << down + 1 unless (mass + 1)  % ::BOARD_SIZE == 0
      cache_neighbors(mass, neighbors)
      @memo_neighbors[mass]
    end

    def apply_attacking_move(move)
      # @grids.map.with_index do |grid, idx|
      #   next [move.attacker, 1] if idx == move.src_index
      #   next [move.attacker, dice_of(@grids[] if idx == move.dst_index
      #   grid
      # end
    end

    def attacking_moves(cur_player)
      attack_lst = []
      @grids.size.times do |src|
        next if player_of(@grids[src]) != cur_player
        neighbors_of(src).each do |dst|
          if player_of(@grids[dst]) != player_of(@grids[src]) && dice_of(@grids[src]) > dice_of(@grids[dst])
            attack_lst << AttackingMove.new(src, dst, cur_player)
          end
        end
      end
      attack_lst
    end

    def add_new_dice(cur_player, spare_dice)
      players_territory = @grids.each.collect { |grid| grid if player_of(grid) == cur_player && dice_of(grid) < ::MAX_DICE }.compact
      return if players_territory.empty? || spare_dice == 0
      players_territory.each do |grid|
        if spare_dice > 0 && dice_of(grid) < ::MAX_DICE
          grid[1] += 1
          spare_dice -= 1
        end
      end
      add_new_dice(cur_player, spare_dice)
    end

    private

    def player_of(grid)
      grid[0]
    end

    def dice_of(grid)
      grid[1]
    end

    def cache_neighbors(mass, neighbors)
      @memo_neighbors[mass] = neighbors.map.sort.select { |neighbor| neighbor >= 0 && neighbor < ::BOARD_HEXNUM }
    end

  end
end
