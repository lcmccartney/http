class WordSearch
  attr_reader :words

  def initialize(source = '/usr/share/dict/words')
    @words = File.read(source).split("\n").map(&:downcase)
  end

  def find_word(word)
    words.include?(word)
  end

end
