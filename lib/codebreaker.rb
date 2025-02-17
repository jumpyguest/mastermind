class Codebreaker
  attr_reader :guess, :swaszek_array

  def initialize
    @guess = Array.new(4)
    @swaszek_array = Array.new { Array.new }
  end

  def prompt_guess(turn, board)
    puts "\nTurn #{turn}"
    puts "You are the codebreaker!"
    puts "Enter the first letter of each color of your 4-color guess. For example: 'rygc'"
    puts "Color Options: r (red), y (yellow), g (green), m (magenta), c (cyan), w (white)"
    @guess = Game.enter_code
    board.update_code_pegs(turn-1, @guess)
  end

  def generate_guess(turn, board, feedback)
    if (turn == 1)
      @guess = Board::CODE_COLORS.sample(4)
      @swaszek_array = Board::CODE_COLORS.permutation(4).to_a
      p @swaszek_array.size
    else
      analyze_feedback(feedback)
      @guess = @swaszek_array[0]
    end
    board.update_code_pegs(turn-1, @guess)
  end

  def analyze_feedback(feedback)
    puts "analyze_feedback"
    @swaszek_array.select! do |element|
      Codemaker.generate_key_pegs(element, @guess) == feedback
    end
  end
end