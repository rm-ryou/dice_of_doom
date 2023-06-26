require "test/unit"
require "../lib/dice_of_doom/board"

MAX_DICE = 3
BOARD_SIZE = 3
BOARD_HEXNUM = 9
NUM_PLAYERS = 2

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

  def test_neighbors_of
    board = ::DiceOfDoom::Board.new
    assert_equal [1, 2, 3], board.neighbors_of(0)
  end
end
