require 'minitest/autorun'
require 'minitest/pride'
require './lib/parser'
require 'faraday'

class ParserTest < Minitest::Test
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

  def setup
    @parser = Parser.new(request_lines)
  end

  def test_it_finds_the_verb
    assert_equal "GET", parser.verb
  end

  def test_it_finds_the_path
    assert_equal "/", parser.path
  end

  def test_it_finds_the_protocol
    assert_equal "HTTP/1.1", parser.protocol
  end

  def test_it_finds_the_host
    assert_equal "127.0.0.1", parser.host
  end

  def test_it_finds_the_port
    assert_equal "9292", parser.port
  end

  def test_it_finds_the_origin
    assert_equal "127.0.0.1", parser.origin
  end

  def test_it_finds_the_accept
    assert_equal "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8", parser.accept
  end

  def test_to_make_sure_formatted_rls_return_hash
    assert_kind_of Hash, parser.diagnostics
  end

  def test_it_is_formatted_string_of_diagnostic_info
    assert_kind_of String, parser.parsed_diagnostics
    refute parser.parsed_diagnostics.empty?
  end

end
