require_relative 'board'

class Codemaker
  WINNING_FEEDBACK = ['r', 'r', 'r', 'r']

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
    feedback = Array.new
    white_keypeg_count = 0
    guess.each_with_index do |peg, index|
      if peg == @code[index]
        feedback.push('r')
      elsif @code.include?(peg)
        white_keypeg_count += 1
      end
    end
    white_keypeg_count.times {feedback.push('w')}
    board.update_key_pegs(turn-1, feedback)
  end

  def prompt_feedback(turn, board)
    puts "\nTurn #{turn}"
    puts "Computer has provided his guess."
    puts "Enter 'r' (red) for each correct code peg position and 'w' (white) for each correct code peg color but wrong position"
    puts "Color Options: r (red), w (white). For example: 'rrww'"
    @feedback = Game.enter_key
    board.update_key_pegs(turn-1, @feedback)
  end

  def guess_correct?(feedback)
    if feedback.eql?(WINNING_FEEDBACK)
      puts "Codebreaker got the code correctly!"
      return true
    end
  end
end