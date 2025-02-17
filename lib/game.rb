class Game
  NUM_TURNS = 4
  NUM_ROUNDS = 2
  NUM_CODE_PEGS = 4

  def initialize
    @human_score = 0
    @computer_score = 0
    @turn = 0
  end

  def play_as_codemaker
    board = Board.new
    codemaker = Codemaker.new
    codebreaker = Codebreaker.new
    
    codemaker.prompt_code
    for n in 1..NUM_TURNS
      @turn = n
      codebreaker.generate_guess(n, board)
      board.print_board
      codemaker.prompt_feedback(n, board)
    end
    board.print_board
  end
  
  def play_as_codebreaker
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
      if codemaker.guess_correct?(board.key_pegs[n-1])
        self.declare_score(@turn)
        return
      end
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
      code = gets.chomp.downcase.split('')
      next if code.empty?
      code.each do |color|
        unless Board::CODE_COLORS.include?(color) && code.count(color) == 1 && code.length == 4
          puts "Invalid code!"
          valid = false
          break
        end
      end
      return code if valid == true
    end
  end

  def self.enter_key
    loop do
      valid = true
      print "Please enter feedback: "
      code = gets.chomp.downcase.split('')
      next if code.empty?
      code.each do |color|
        unless Board::KEY_COLORS.include?(color) && code.length <= 4
          puts "Invalid feedback!"
          valid = false
          break
        end
      end
      return code if valid == true
    end
  end

end