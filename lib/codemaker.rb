require_relative 'board'

class Codemaker
  def initialize
    @code = Array.new(4)
  end

  def generate_code
    @code = Board::COLORS.sample(4)
    p @code
  end
  
  def start_game
    puts "You are the codemaker!"
    puts "Choose a 4-color code from 6 colors: r (red), y (yellow), g (green), b (blue), m (magenta), c (cyan)"
    puts "Example: 'rygb'"
    loop do
      valid = true
      print "Please enter the code: "
      str_code = gets.chomp
      @code = str_code.split('')
      @code.each do |color|
        unless Board::COLORS.include?(color) && @code.count(color) == 1
          puts "Invalid color!"
          valid = false
          break
        end
      end
      return if valid == true
    end
  end
end