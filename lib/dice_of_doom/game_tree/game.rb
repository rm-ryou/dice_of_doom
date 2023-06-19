module DiceOfDoom
  module GameTree
    class Game
      include Board

      attr_accessor :game_tree
      
      def initialize
        @game_tree = Tree.new
        board = [ [ 1, 2 ], [ 1, 2 ], [ 0, 2 ], [ 1, 1 ] ]
        # board = [ [ 0, 3 ], [ 0, 3 ], [ 1, 2 ], [ 1, 3 ] ]
        # board = [ [1, 1], [0, 2], [0, 3],  [0, 1], [1, 1], [1, 2], [1, 2], [0, 2], [1, 3] ]
        @cur_node = @game_tree.root = Node.new(board, 0)
        # @cur_node = @game_tree.root = Node.new(gen_board, 0)
        p @cur_node.board
        @memo_tree = {}
        first_moves = add_passing_move(@game_tree.root, attacking_moves(@game_tree.root))
        create_tree(@cur_node, first_moves)
      end

      def tree
        @game_tree.root
      end

      def create_tree(parent, moves)
        @memo_tree[parent] = moves
        parent.child = moves
        parent.child.each { |new_parent| 
          new_moves = add_passing_move(new_parent, attacking_moves(new_parent))
          create_tree(new_parent, new_moves)
        }
      end

      def add_passing_move(cur_node, moves)
        return moves if cur_node.first_move?
        if @memo_tree.key?(cur_node)
          puts "*" * 10
          puts "true"
          puts "*" * 10
          create_tree(cur_node, @memo_tree[cur_node])
        end

        moves.each do |move|
          add_new_dice(move, ->(player) { player == move.player }, move.spare - 1)
          move = Node.new(move.board, (move.player + 1) % ::NUM_PLAYERS)
        end
        # end turn用
        tmp = Node.new(dup_board(cur_node.board), cur_node.player, cur_node.spare, cur_node.first_move)
        add_new_dice(tmp, ->(player) { player == tmp.player }, tmp.spare - 1)
        moves.unshift(Node.new(tmp.board, (cur_node.player + 1) % ::NUM_PLAYERS))
        moves
      end

      def attacking_moves(parent_node)
        player = ->(pos) { parent_node.board[pos][0] }
        dice   = ->(pos) { parent_node.board[pos][1] }
        moves = []
        if @memo_tree.key?(parent_node)
          return @memo_tree[parent_node]
        end
        (0...::BOARD_HEXNUM).each do |src|
          # srcが攻撃者なため
          next if player.call(src) != parent_node.player
          neighbors(src).each do |neighbor|
            if player.call(neighbor) != player.call(src) && dice.call(src) > dice.call(neighbor)
              attack_lst = [src, neighbor]
              attacked_board = board_attack(dup_board(parent_node.board), parent_node.player, src, neighbor, dice.call(src))
              spare = dice.call(neighbor)
              move = Node.new(attacked_board, parent_node.player, parent_node.spare + spare, false, attack_lst)
              moves << move
            end
          end
        end
        moves
      end
    end
  end
end
