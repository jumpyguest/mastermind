class Codebreaker
  def initialize
    @guess = Array.new(4)
  end

  def prompt_guess(turn, board)
    puts "\nTurn #{@turn}"
    puts "You are the codebreaker!"
    puts "Enter the first letter of each color of your 4-color guess. For example: 'rygb'"
    puts "Color Options: r (red), y (yellow), g (green), b (blue), m (magenta), c (cyan)"
    @guess = board.enter_code
    board.update_code_pegs(turn, @guess)
  end
end