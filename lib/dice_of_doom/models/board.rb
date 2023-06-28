module DiceOfDoom
  class Board
    attr_reader :grids

    class << self
      def gen_grids
        gen_array.map { |grid| grid = [gen_random_player, gen_random_dice] }
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
    end

    def neighbors_of(mass)
      @memo_neighbors ||= {}
      return @memo_neighbors[mass] if @memo_neighbors.has_key?(mass)

      up   = mass - ::BOARD_SIZE
      down = mass + ::BOARD_SIZE
      neighbors = [up, down]
      neighbors << up - 1   << mass - 1 unless mass       % ::BOARD_SIZE == 0
      neighbors << down + 1 << down + 1 unless (mass + 1) % ::BOARD_SIZE == 0
      cache_neighbors(mass, neighbors)
      @memo_neighbors[mass]
    end

    def apply_attacking_move(move)
      dup_grids.map.with_index do |grid, index|
        next [move.attacker, 1]                                   if index == move.src_index
        next [move.attacker, dice_of(@grids[move.src_index]) - 1] if index == move.dst_index
        grid
      end
    end

    def attacking_moves(player_id)
      attack_list = []
      @grids.size.times do |src|
        next if player_of(@grids[src]) != player_id
        neighbors_of(src).each do |dst|
          attack_list << AttackingMove.new(src, dst, player_id) if attacable?(src, dst)
        end
      end
      attack_list
    end

    def add_new_dice(player_id, spare_dice)
      players_territory = @grids.each.collect { |grid| grid if player_of(grid) == player_id && dice_of(grid) < ::MAX_DICE }.compact
      return if players_territory.empty? || spare_dice <= 0
      players_territory.each do |grid|
        if spare_dice > 0 && dice_of(grid) < ::MAX_DICE
          grid[1] += 1
          spare_dice -= 1
        end
      end
      add_new_dice(player_id, spare_dice)
    end

    private

    def player_of(grid)
      grid[0]
    end

    def dice_of(grid)
      grid[1]
    end

    def attacable?(src, dst)
      player_of(@grids[dst]) != player_of(@grids[src]) && dice_of(@grids[src]) > dice_of(@grids[dst])
    end

    def cache_neighbors(mass, neighbors)
      @memo_neighbors[mass] = neighbors.map.sort.select { |neighbor| neighbor >= 0 && neighbor < ::BOARD_HEXNUM }
    end

    def dup_grids
      new_grids = Board.gen_array
      @grids.each_with_index do |grid, index|
        new_grids[index] = grid.dup
      end
      new_grids
    end
  end
end
