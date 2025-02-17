require_relative 'board'

class Codemaker
  WINNING_FEEDBACK = ['r', 'r', 'r', 'r']
  attr_reader :feedback

  def initialize
    @code = Array.new(4)
    @feedback = Array.new(4)
  end

  def generate_code
    @code = Board::CODE_COLORS.sample(4)
    puts "codemaker generated code #{@code}"
  end

  def prompt_code
    puts "You are the codemaker!"
    puts "Enter the first letter of each color of your 4-color code. For example: 'rygc'"
    puts "Color Options: r (red), y (yellow), g (green), m (magenta), c (cyan), w (white)"
    @code = Game.enter_code
  end

  def check_guess(turn, board, guess)
    @feedback = generate_key_pegs(guess, @code).sort!
    board.update_key_pegs(turn-1, @feedback)
  end

  def self.generate_key_pegs(guess, code)
    feedback = Array.new
    guess.each_with_index do |peg, index|
      if peg == code[index]
        feedback.push('r')
      elsif code.include?(peg)
        feedback.push('w')
      end
    end
    return feedback
  end

  def prompt_feedback(turn, board)
    puts "\nTurn #{turn}"
    puts "Computer has provided his guess."
    puts "Enter 'r' (red) for each correct code peg position and 'w' (white) for each correct code peg color but wrong position"
    puts "Color Options: r (red), w (white). Examples: 'rrww', 'wrw', 'r'"
    @feedback = Game.enter_key
    board.update_key_pegs(turn-1, @feedback)
  end

  def guess_correct?
    if @feedback.eql?(WINNING_FEEDBACK)
      puts "Codebreaker got the code correctly!"
      return true
    end
  end
end