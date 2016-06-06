require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'
require './lib/game'

class GameTest < Minitest::Test

  def test_it_picks_a_random_number
    skip
    game = Game.new
    assert_kind_of Float game.random_num
  end

  def test_it_starts_with_zero_as_guess_count
    skip
    game = Game.new
    assert_equal 0, game.guess_count
  end

  def test_it_has_a_welcome_message_string
    game = Game.new
    assert_kind_of String, game.welcome
  end

  def test_guess_count_increments_by_one
    game = Game.new
    assert_kind_of String, game.game_get
  end

end
