require 'minitest/autorun'
require 'minitest/pride'
require './lib/server'
require 'faraday'

class ServerTest < Minitest::Test

  def test_it_starts_the_server
    server = Server.new
    assert_instance_of Server, server
  end

  def test_it_can_get_response_from_running_server
    skip
    response = Faraday.get 'http://127.0.0.1:9292/'
    assert_equal 200, response.get
  end

  def test_it_can_get_response_from_hello_path
    skip
    response = Faraday.get 'http://127.0.0.1:9292/hello'
    assert_equal 200, response.body.include?("Hello")
  end

  def test_it_can_get_response_from_word_search_path
    skip
    response = Faraday.get 'http://127.0.0.1:9292/word_search?word=bird'
    assert_equal 200, response.body.include?("Bird is a word.")
  end

  def test_it_can_get_a_response_from_number_guessing_game
    skip
    response = Faraday.get 'http://127.0.0.1:9292/word_search?word=bird'
    assert_equal 200, response.body.include?("Game Started!")
  end

end
