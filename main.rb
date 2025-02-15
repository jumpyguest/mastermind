# require_relative 'lib/codemaker'
require_relative 'lib/codebreaker'
require_relative 'lib/board'

board = Board.new
codebreaker = Codebreaker.new
board.print_board
codebreaker.prompt_guess(1, board)