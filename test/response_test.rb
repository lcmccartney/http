require 'minitest/autorun'
require 'minitest/pride'
require './lib/parser'
require './lib/response'

class ResponseTest < Minitest::Test
  attr_reader :parser

  def request_lines
    ["GET / HTTP/1.1",
    "Host: 127.0.0.1:9292",
    "Connection: keep-alive",
    "Cache-Control: max-age=0",
    "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
    "Upgrade-Insecure-Requests: 1",
    "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
    "Accept-Encoding: gzip, deflate, sdch",
    "Accept-Language: en-US,en;q=0.8"]
  end

  def test_it_returns_a_path
    resp = Response.new
    assert_equal "/", resp.return_path(request_lines)
  end

  def test_root_path_returns_empty_path_with_parser
    resp = Response.new
    parser = Parser.new(request_lines).parsed_diagnostics
    assert_equal "/", resp.return_path(request_lines)
  end

  def test_it_returns_hello_word_with_counter
    resp = Response.new
    hello_count = 0
    assert resp.hello(hello_count).include?("Hello World")
    refute resp.hello(hello_count).include?("thisdoesnotexist")
  end

  def test_root_returns_a_verb
    resp = Response.new
    parser = Parser.new(request_lines)
    assert resp.root(request_lines).include?("Verb")
  end

  def test_datetime_returns_a_string
    resp = Response.new
    assert_kind_of String, resp.datetime
  end

  def test_shutdown_includes_request_count
    resp = Response.new
    parser = Parser.new(request_lines)
    request_count = 0
    assert resp.shutdown(request_count).include?("Total Requests")
  end

  def word_search_returns_feedback_on_word
    resp = Response.new
    assert word_search(request_lines).include?("is a word.")
  end

end
