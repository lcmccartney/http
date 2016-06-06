require 'socket'
require './lib/parser'
require './lib/server'
require './lib/word_search'

class Response

  def return_path(request_lines)
    parser = Parser.new(request_lines)
    parser.path
  end

  def hello(hello_count)
    "<html><body><pre>" + "Hello World! (#{hello_count})\n" + "</pre></body></html>"
  end

  def root(request_lines)
    "<html><body><pre>" + Parser.new(request_lines).parsed_diagnostics + "</pre></body></html>"
  end

  def datetime
    "<html><body><pre>" + Time.now.strftime('%a, %e %b %Y %H:%M:%S %z') + "</pre></body></html>"
  end

  def shutdown(request_count)
    "<html><body><pre>" + "Total Requests: (#{request_count})\n" + "</pre></body></html>"
  end

  def word_search(request_lines)
    word = Parser.new(request_lines).word_params['word']
    if WordSearch.new.find_word(word)
      "#{word.capitalize} is a word."
    else
      "#{word.capitalize} is NOT a word."
    end
  end

end
