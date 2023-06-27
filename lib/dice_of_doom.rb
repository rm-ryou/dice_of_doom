require "dice_of_doom/attacking_move"
require "dice_of_doom/board"
require "dice_of_doom/node"
require "dice_of_doom/game_tree"
require "dice_of_doom/default_player"
require "dice_of_doom/human"
require "dice_of_doom/computer"
require "dice_of_doom/command"

module DiceOfDoom
  VERSION = '1.0.0'.freeze

  class << self
    def version
      VERSION
    end
  end
end

