class Codebreaker
  attr_reader :guess

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
      @guess = Board::CODE_COLORS.sample(Game::NUM_CODE_PEGS)
      @swaszek_array = Board::CODE_COLORS.permutation(Game::NUM_CODE_PEGS).to_a
    else
      analyze_feedback(feedback)
      @guess = @swaszek_array[0]
    end
    board.update_code_pegs(turn-1, @guess)
  end

  def analyze_feedback(feedback)
    @swaszek_array.select! do |element|
      Codemaker.generate_key_pegs(element, @guess) == feedback
    end
  end

  private

  attr_reader :swaszek_array
end