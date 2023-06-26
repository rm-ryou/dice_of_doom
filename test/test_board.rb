require "test/unit"
require "../lib/dice_of_doom/board"

MAX_DICE = 3

class BoardTest < Test::Unit::TestCase
  def test_add_new_dice
    grids = [[0, 2], [0, 3], [0, 2],
             [0, 3], [1, 3], [0, 2],
             [0, 2], [0, 1], [0, 3]]
    board = ::DiceOfDoom::Board.new(grids)
    board.add_new_dice(0, 3)
    assert_equal  [[0, 3], [0, 3], [0, 3], [0, 3], [1, 3], [0, 3], [0, 2], [0, 1], [0, 3]],
                  board.grids
  end
end
