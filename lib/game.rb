class Game
  NUM_TURNS = 10
  NUM_ROUNDS = 2
  NUM_CODE_PEGS = 4

  @@round = 1

  def initialize
    @human_score = 0
    @computer_score = 0
    @turn = 0
  end

  def start_game
    puts "+++ Welcome to MASTERMIND +++"
    puts "\nThis game has two rounds. You can choose to either start as Codebreaker or Codemaker.\n"
    puts "Enter your choice [1] - Codebreaker   [2] - Codemaker: "
    ans = nil
    until ans == '1' || ans == '2' do
      ans = gets.chomp
    end
    if ans == '1'
      play_as_codebreaker
      puts "\n=============================== Round #{@@round+=1} ==============================="
      play_as_codemaker
    elsif ans == '2'
      play_as_codemaker
      puts "\n=============================== Round #{@@round+=1} ==============================="
      play_as_codebreaker
    end
  end

  def self.enter_code
    loop do
      valid = true
      print "Please enter the code: "
      code = gets.chomp.downcase.split('')
      next if code.empty?
      code.each do |color|
        unless Board::CODE_COLORS.include?(color) && code.count(color) == 1 && code.length == NUM_CODE_PEGS
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
        unless Board::KEY_COLORS.include?(color) && code.length <= NUM_CODE_PEGS
          puts "Invalid feedback!"
          valid = false
          break
        end
      end
      return code if valid == true
    end
  end

  private

  def play_as_codemaker
    board = Board.new
    codemaker = Codemaker.new
    codebreaker = Codebreaker.new
    
    codemaker.prompt_code
    for n in 1..NUM_TURNS
      @turn = n
      codebreaker.generate_guess(n, board, codemaker.feedback)
      board.print_board
      codemaker.prompt_feedback(n, board)
      board.print_board
      if codemaker.guess_correct?
        self.declare_score(@turn, false)
        return
      end
    end
    puts "\nCodebreaker ran out of guesses.".colorize(:red) if @turn == NUM_TURNS
    self.declare_score(@turn, false)
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
      if codemaker.guess_correct?
        self.declare_score(@turn, true)
        return
      end
    end
    puts "\nCodebreaker ran out of guesses.".colorize(:red) if @turn == NUM_TURNS
    self.declare_score(@turn, true)
  end

  def declare_score(turn, is_code_breaker)
    score = (turn == NUM_TURNS) ? NUM_TURNS+1 : turn
    if is_code_breaker then @computer_score = score
    else @human_score = score
    end
    puts "Human score: #{@human_score}   Computer score: #{@computer_score}"
    if @@round == NUM_ROUNDS
      if @human_score == @computer_score
        puts "It's a Draw!".colorize(:red)
      else
        winner = @human_score > @computer_score ? "Human" : "Computer"
        puts "#{winner} wins!!".colorize(:green)
      end
    end
  end

  def self.round?
    @@round
  end
end