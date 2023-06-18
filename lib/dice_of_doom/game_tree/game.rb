module DiceOfDoom
  module GameTree
    class Game
      include Board

      attr_accessor :game_tree
      
      def initialize
        @game_tree = Tree.new
        board = [ [ 1, 2 ], [ 1, 2 ], [ 0, 2 ], [ 1, 1 ] ]
        # board = gen_board



        @cur_node = @game_tree.root = Node.new(board, 0)

        add_passing_move(@game_tree.root, attacking_moves(@game_tree.root))
        # create_tree(@game_tree.root, attacking_moves(@game_tree.root))
        # add_passing_move(nil, attacking_moves(@game_tree.root))
        # p attacking_moves(@game_tree.root)

      end

      def tree
        @game_tree.root
      end

      def create_tree(parent, node)
        parent.add_child(node)
        add_passing_move(node, attacking_moves(node))
      end

      def add_passing_move(cur_node, moves)
        return if cur_node.first_move == true
        p moves[0].attack_lst
        # create_tree(cur_node, Node.new(moves[0].board, (moves[0].player + 1) % ::NUM_PLAYERS))
        i = 0
          puts "board = #{cur_node.board}"
        while moves[i]
          add_new_dice(moves[i], ->(player) { player == moves[i].player }, moves[i].spare - 1)
          # add_new_dice(moves[i], ->(player) { player == moves[i].player }, cur_node.spare - 1)
          puts "attack lst = #{moves[i].attack_lst[0]} -> #{moves[i].attack_lst[1]}"
          create_tree(cur_node, Node.new(moves[i].board, (moves[i].player + 1) % ::NUM_PLAYERS))
          i += 1
        end
      end

      def attacking_moves(parent_node)
        player = ->(pos) { parent_node.board[pos][0] }
        dice   = ->(pos) { parent_node.board[pos][1] }
        # end turn 用
        # moves = []
        # moves = parent_node.first_move? ? [] : [parent_node]
        moves = [parent_node]
        (0...::BOARD_HEXNUM).each do |src|
          # srcが攻撃者なため
          next if player.call(src) != parent_node.player
          neighbors(src).each do |neighbor|
            if player.call(neighbor) != player.call(src) && dice.call(src) > dice.call(neighbor)
              attacked_board = board_attack(dup_board(parent_node.board), parent_node.player, src, neighbor, dice.call(src))
              spare = dice.call(neighbor)
              next_node = Node.new(attacked_board, parent_node.player, parent_node.spare + spare, false)
              next_node.attack_lst << src << neighbor
              # p next_node.attack_lst
              moves << next_node
              create_tree(parent_node, next_node)
            end
          end
        end
        # p "moves = #{moves}"
        # puts
        return moves.empty? ? [parent_node] : moves
        # moves
      end
    end
  end
end
