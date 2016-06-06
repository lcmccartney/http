require 'minitest/autorun'
require 'minitest/pride'
require './lib/word_search'

class WordSearchTest < Minitest::Test

  def test_it_finds_a_word_in_dictionary
    ws = WordSearch.new
    word = "aardvark"
    assert ws.find_word(word)

    word = "zygopteraceae"
    assert ws.find_word(word)
  end

  def test_it_does_not_find_fake_word
    ws = WordSearch.new
    word = "fghjkfghjj"
    refute ws.find_word(word)
  end

  def test_typically_upcased_word_is_downcased
    ws = WordSearch.new
    word = "Zythia"
    refute ws.find_word(word)

    word = "zythia"
    assert ws.find_word(word)
  end

end
