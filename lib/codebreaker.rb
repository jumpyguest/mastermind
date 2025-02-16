class Codebreaker
  attr_reader :guess

  def initialize
    @guess = Array.new(4)
  end

  def prompt_guess(turn, board)
    puts "\nTurn #{turn}"
    puts "You are the codebreaker!"
    puts "Enter the first letter of each color of your 4-color guess. For example: 'rygc'"
    puts "Color Options: r (red), y (yellow), g (green), m (magenta), c (cyan), w (white)"
    @guess = Game.enter_code
    board.update_code_pegs(turn-1, @guess)
  end
end