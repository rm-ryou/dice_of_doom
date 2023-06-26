require "dice_of_doom/attacking_move"
require "dice_of_doom/board"
require "dice_of_doom/node"
require "dice_of_doom/game_tree"

module DiceOfDoom
  VERSION = '1.0.0'.freeze

  class << self
    def version
      VERSION
    end
  end
end

