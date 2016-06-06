require 'socket'
require './lib/parser'
require './lib/response'
require './lib/game'

class Server

  attr_reader :tcp_server,
              :request_lines,
              :hello_count,
              :client,
              :game

  def initialize
    @tcp_server = TCPServer.new(9292)
    @request_count = 0
    @hello_count = 0
    @game = nil
  end

  def fetch_request_lines
    puts "Ready for a request..."
    @request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
  end

  def start_game
    @game = Game.new
    game.welcome
  end

  def get_post_content
    parser = Parser.new(@request_lines)
    content_length = parser.content_length
    @client.read content_length.to_i
  end

  def redirect(url)
    header = ["http/1.1 301 Moved Permanently",
     "Location: #{url}",
     "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
     "server: ruby",
     "content-type: text/html; charset=iso-8859-1\r\n\r\n"].join("\r\n")
     client.puts header
   end

  def start
    while
      @client = @tcp_server.accept
      fetch_request_lines
      @request_count += 1

      output = call_path(request_lines, @request_count, @hello_count)

      @hello_count += 1 if Response.new.return_path(request_lines) == "/hello"
      client.puts output
      client.close
    end
  end

  def call_path(request_lines, request_count, hello_count)
    resp = Response.new
    path = resp.return_path(request_lines)

    if path == "/"
      resp.root(request_lines)
    elsif path == "/hello"
      resp.hello(hello_count)
    elsif path == "/datetime"
      resp.datetime
    elsif path.include?("word_search")
      resp.word_search(request_lines)
    elsif path == "/start_game"
      start_game
    elsif path == "/game"
      game_path
    else path == "/shutdown"
      resp.shutdown(request_count)
    end
  end

  def game_path
    parser = Parser.new(request_lines)
    if @game != nil
      if parser.verb == "POST"
        redirect(@game.game_post(get_post_content))
      elsif parser.verb == "GET"
        @game.game_get
      end
    end
  end


end
