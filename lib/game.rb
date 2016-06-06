class Game

  def initialize
    @guess_count = 0
    @last_guess = nil
    @random_num = random_num
  end

  def random_num
    rand(0..100)
  end

  def welcome
    "<html><body><pre>Game started!</pre></body></html>"
  end

  def game_post(content)
    @last_guess = content.to_i
    @guess_count += 1
    "http://127.0.0.1:9292/game"
  end

  def game_get
    guess_info = ""
    if @last_guess != nil
      guess_info = "Last guess was: " + @last_guess.to_s + "\n"
      if @last_guess > @random_num
        guess_info = guess_info + "This is too high."
      elsif @last_guess < @random_num
        guess_info = guess_info + "This is too low."
      else @last_guess == @random_num
        guess_info = guess_info + "You won!"
      end
    end
    "<html><body><pre>Total Guesses: #{@guess_count}\n#{guess_info}\n</pre></body></html>"
  end
  
end
