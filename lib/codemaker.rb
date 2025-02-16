require_relative 'board'

class Codemaker
  WINNING_FEEDBACK = ['r', 'r', 'r', 'r']

  def initialize
    @code = Array.new(4)
  end

  def generate_code
    @code = Board::COLORS.sample(4)
    puts "codemaker generated code #{@code}"
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

  def guess_correct?(feedback)
    if feedback.eql?(WINNING_FEEDBACK)
      puts "Codebreaker got the code correctly!"
      return true
    end
  end
end