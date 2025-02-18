require 'colorize'

class Board
  COLORS_HASH = {'r'=>'red', 'y'=>'yellow', 'g'=>'green', 'm'=>'magenta', 'c'=>'cyan', 'w'=>'white', 'e' => 'grey'}
  CODE_COLORS = ['r', 'y', 'g', 'm', 'c', 'w']
  KEY_COLORS = ['r', 'w']

  attr_reader :key_pegs

  def initialize
    @code_pegs = Array.new(Game::NUM_TURNS) {Array.new(Game::NUM_CODE_PEGS, 'e')}
    @key_pegs = Array.new(Game::NUM_TURNS) {Array.new(Game::NUM_CODE_PEGS, 'e')}
  end

  def print_board
    puts "--- Round #{Game::round?} ---"
    puts " guess  |  check"

    @code_pegs.reverse.each_with_index do |row, index|
      row_display = row.map {|peg| peg == nil ? '●' : '●'.colorize(COLORS_HASH[peg].to_sym)}
      row_display_key = @key_pegs.reverse[index].map {|key_peg| key_peg == nil ? '●' : '●'.colorize(COLORS_HASH[key_peg].to_sym)}
      puts row_display.join(' ') + ' | ' + row_display_key.join(' ')
    end
  end

  def update_code_pegs(turn, guess)
    @code_pegs[turn] = guess
  end

  def update_key_pegs(turn, feedback)
    @key_pegs[turn] = feedback
  end
end