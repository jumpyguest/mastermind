class Game
  NUM_TURNS = 4
  NUM_ROUNDS = 2
  NUM_CODE_PEGS = 4

  def initialize
    @human_score = 0
    @computer_score = 0
    @turn = 0
  end

  def play
    board = Board.new
    codebreaker = Codebreaker.new
    codemaker = Codemaker.new

    codemaker.generate_code
    board.print_board
    for n in 1..NUM_TURNS
      @turn = n
      codebreaker.prompt_guess(n, board)
      codemaker.check_guess(n, board, codebreaker.guess)
      board.print_board
      break if codemaker.guess_correct?(board.key_pegs[n-1])
    end
    puts "Codebreaker ran out of guesses." if @turn == 4
    self.declare_score(@turn)
  end

  def declare_score(turn)
    @computer_score = (turn == 4) ? 5 : turn
    puts "Human score: #{@human_score}   Computer score: #{@computer_score}"
  end

  def self.enter_code
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

end