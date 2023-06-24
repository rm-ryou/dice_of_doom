require "dice_wars/models/state/board"
require "dice_wars/models/tree/node"
require "dice_wars/models/tree/tree"

require "dice_wars/commands/geme_tree"


module DiceWars
  VERSION = '1.0.0'.freeze

  class << self
    def version
      VERSION
    end
  end
end
