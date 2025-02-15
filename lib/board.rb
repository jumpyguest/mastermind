require 'colorize'

class Board
  COLORS_HASH = {'r'=>'red', 'y'=>'yellow', 'g'=>'green', 'b'=>'blue', 'm'=>'magenta', 'c'=>'cyan', 'w'=>'white'}
  COLORS = ['r', 'y', 'g', 'b', 'm', 'c']
  NUM_TURNS = 10
  NUM_ROUNDS = 2

  def initialize
    @turn = 1
    @round = 1
    @code_pegs = Array.new(10) {Array.new(4, 'c')}
    @key_pegs = Array.new(10) {Array.new(4, 'y')}
  end

  def print_board
    puts "--- Round #{@round} ---"
    puts " guess  |  check"

    @code_pegs.reverse.each_with_index do |row, index|
      row_display = row.map {|peg| peg == nil ? '●' : '●'.colorize(COLORS_HASH[peg].to_sym)}
      row_display_key = @key_pegs.reverse[index].map {|key_peg| key_peg == nil ? '●' : '●'.colorize(COLORS_HASH[key_peg].to_sym)}
      puts row_display.join(' ') + ' | ' + row_display_key.join(' ')
    end
  end

  def enter_code
    loop do
      valid = true
      print "Please enter the code: "
      code = gets.chomp.split('')
      code.each do |color|
        unless Board::COLORS.include?(color) && code.count(color) == 1
          puts "Invalid color!"
          valid = false
          break
        end
      end
      return code if valid == true
    end
  end

  def update_code_pegs(turn, guess)
    @code_pegs[turn] = guess
    puts "update_code_pegs"
    p @code_pegs[turn]
  end
end