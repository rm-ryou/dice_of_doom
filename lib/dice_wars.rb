require "dice_wars/models/board"
require "dice_wars/models/node"
require "dice_wars/commands/ai"
require "dice_wars/models/default_player"
require "dice_wars/models/player"


require "dice_wars/commands/geme_tree"
require "dice_wars/commands/command"


module DiceWars
  VERSION = '1.0.0'.freeze

  class << self
    def version
      VERSION
    end
  end
end
