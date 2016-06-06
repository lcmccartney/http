require './lib/server'
require './lib/response'
require './lib/word_search'

class Parser
  attr_reader :request_lines

  def initialize(request_lines)
    @request_lines = request_lines
  end

  def diagnostics
    parsed_lines = {}
    parsed_lines["Verb: "]          = verb
    parsed_lines["Path: "]          = path
    parsed_lines["Protocol: "]      = protocol
    parsed_lines["Host: "]          = host
    parsed_lines["Port: "]          = port
    parsed_lines["Origin: "]        = origin
    parsed_lines["Accept: "]        = accept
    parsed_lines["Content-Length"]  = content_length
    parsed_lines
  end

  def verb
    request_lines[0].split('/')[0].split(" ")[0]
  end

  def path
    request_lines[0].split(' ')[1]
  end

  def protocol
    request_lines[0].split(' ')[2]
  end

  def host
    request_lines[1].split(":")[1].strip
  end

  def port
    request_lines[1].split(":")[2]
  end

  def origin
    request_lines[1].split(":")[1].strip
  end

  def accept
    line = request_lines.find do |chars|
      chars.include?("Accept:")
    end
    line.split(":")[1].strip
  end

  def content_length
    line = request_lines.find do |chars|
      chars.include?("Content-Length:")
    end
    if line == nil
      ""
    else
      line.split(":")[1].strip
    end
  end

  def parsed_diagnostics
    output = diagnostics.map do |line|
      line * ""
    end
    output.join("\n")
  end

  def word_params
    param_pair = {}
    params1 = path.split("?")[1]
    params2 = params1.split("&")
    params2.each do |pair|
      key, value = pair.split("=")
      param_pair[key] = value
    end
    param_pair
  end

end
