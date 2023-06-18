module DiceOfDoom
  module GameTree
    class Game
      include Board

      attr_accessor :game_tree
      
      def initialize
        @game_tree = Tree.new
        # board = [ [ 0, 1 ], [ 1, 1 ], [ 0, 2 ], [ 1, 1 ] ]
        # board = [ [ 0, 3 ], [ 1, 3 ], [ 0, 2 ], [ 1, 2 ] ]
        board = [ [ 1, 2 ], [ 1, 2 ], [ 0, 2 ], [ 1, 1 ] ]
        # board = gen_board
        @cur_node = @game_tree.root = Node.new(board, 0)
        add_passing_move(@game_tree.root, attacking_moves(@game_tree.root))

        # tmp = @game_tree.root.child[1]
        # p tmp

        # p tmp.child.size
        # tmp.child.size.times do |chd|
        #   p tmp.child[chd]
        #   puts
        # end
      end

      def tree
        @game_tree.root
      end

      # attr_accessor :board, :player, :spare, :first_move, :attack_lst, :child
      # def create_tree(board, player, spare, first_move)
      # def create_tree(node)
      def create_tree(parent, node)
        # @cur_node.add_child(node)
        # @cur_node = node
        # add_passing_move(attacking_moves)
        parent.add_child(node)
        # @cur_node = node
        add_passing_move(node, attacking_moves(node))
      end

      def add_passing_move(cur_node, moves)
        return if cur_node.first_move? || moves.empty?
        moves.each do |move|
          add_new_dice(move, ->(player) { player == move.player }, move.spare - 1)
          create_tree(cur_node, Node.new(move.board, (move.player + 1) % ::NUM_PLAYERS))
        end
      end

      # def add_passig_move(cur_node, move)
      #   return if cur_node.first_move? || !move
      #   add_new_dice(move, ->(player) { player == move.player }, move.spare - 1)
      #   create_tree(cur_node, Node.new(move.board, (move.player + 1) % ::NUM_PLAYERS))
      # end

      def attacking_moves(parent_node)
        player = ->(pos) { parent_node.board[pos][0] }
        dice   = ->(pos) { parent_node.board[pos][1] }
        moves = []
        (0..::BOARD_HEXNUM - 1).each do |src|
          next if player.call(src) != parent_node.player
          neighbors(src).each do |neighbor|
            if player.call(neighbor) != player.call(src) && dice.call(src) > dice.call(neighbor)
              attacked_board = board_attack(dup_board(parent_node.board), parent_node.player, src, neighbor, dice.call(src))
              spare = dice.call(neighbor)
              next_node = Node.new(attacked_board, parent_node.player, parent_node.spare + spare, false)
              next_node.attack_lst.push(src, neighbor)
              moves << next_node
              # p parent_node.board
              # p next_node.board
              create_tree(parent_node, next_node)
            end
          end
        end
        return moves
      end

# {{{
      # # attr_accessor :board, :player, :spare, :first_move, :attack_lst, :child
      # # def create_tree(board, player, spare, first_move)
      # # def create_tree(node)
      # def create_tree(parent, node)
      #   # @cur_node.add_child(node)
      #   # @cur_node = node
      #   # add_passing_move(attacking_moves)
      #   parent.add_child(node)
      #   @cur_node = node
      #   add_passing_move(attacking_moves)
      # end
# }}}

# {{{
      # def add_passing_move(moves)
      #   return if @cur_node.first_move? || moves.empty?
      #   parent = @cur_node
      #   moves.each do |move|
      #     add_new_dice(move, ->(player) { player == move.player }, move.spare - 1)
      #     create_tree(parent, Node.new(move.board, (move.player + 1) % ::NUM_PLAYERS))
      #   end
      # end
# }}}

      # def attacking_moves
      #   player = ->(pos) { @cur_node.board[pos][0] }
      #   dice   = ->(pos) { @cur_node.board[pos][1] }
      #   parent_node = @cur_node.clone
      #   moves = []
      #   (0..::BOARD_HEXNUM - 1).each do |src|
      #     # next if player.call(src) != @cur_node.player
      #     next if player.call(src) != parent_node.player
      #     neighbors(src).each do |neighbor|
      #       # if player.call(neighbor) != @cur_node.player
      #       # # if player.call(neighbor) != parent_node.player
      #       #   p "2 times #{src} -> #{neighbor}"
      #       #   p dice.call(src) > dice.call(neighbor)
      #       # end
      #       # if player.call(neighbor) != @cur_node.player && dice.call(src) > dice.call(neighbor)
      #       if player.call(neighbor) != player.call(src) && dice.call(src) > dice.call(neighbor)
      #         # attacked_board = board_attack(dup_board(@cur_node.board), @cur_node.player, src, neighbor, @cur_node.board[src][1])
      #         attacked_board = board_attack(dup_board(parent_node.board), parent_node.player, src, neighbor, parent_node.board[src][1])
      #         # spare = @cur_node.board[neighbor][1]
      #         spare = parent_node.board[neighbor][1]
      #         # next_state = State.new(attacked_board, cur_node.state.spare + spare, false)
      #         # next_node = Node.new(attacked_board, @cur_node.player, @cur_node.spare + spare, false)
      #         next_node = Node.new(attacked_board, parent_node.player, parent_node.spare + spare, false)
      #         next_node.attack_lst.push(src, neighbor)
      #         moves << next_node
      #         create_tree(parent_node, next_node)
      #       end
      #     end
      #   end
      #   # ->(dst) { if (player(i, cur_node.state.board) && dice
      #   moves
      # end
    end
  end
end