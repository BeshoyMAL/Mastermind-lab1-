class Board
  
    def init_NoDups(length)
      arr = (1..8).to_a
      arr.shuffle![0, length]
    end
  
    def init_Dups(length)
      Array.new(length) { rand(1..8) }
    end

    def encode(arr)
      colors = { 'red' => 1, 'green' => 2, 'blue' => 3, 'yellow' => 4, 'brown' => 5, 'orange' => 6, 'black' => 7,
                 'white' => 8 }
      arr.map { |i| colors[i.downcase] }
    end
 
    def decode(arr)
      colors = { 'red' => 1, 'green' => 2, 'blue' => 3, 'yellow' => 4, 'brown' => 5, 'orange' => 6, 'black' => 7,
                 'white' => 8 }
      dolors = colors.invert
      arr.map { |i| dolors[i] }
    end
  
    def integrate(answer, query)
      green = align(answer, query)
      yellow = 0
    counted_elements = Hash.new(0)
    answer.each do |i|
      if query.include?(i) && counted_elements[i] < [answer.count(i), query.count(i)].min
        yellow += 1
        counted_elements[i] += 1
      end
    end
      [yellow, green]
    end
  
    private
   
    def align(arr1, arr2)
      num = 0
      (0...arr1.length).each do |i|
        num += 1 if arr1[i] == arr2[i]
      end
      num
    end
  end
  
  class Interface

    def get_code
      puts 'Code Length, Enter 4, 6 or 8'
      while true
        length = gets.chomp.to_i
        return length if [4, 6, 8].include?(length)
  
        puts 'Invalid input, try again'
  
      end
    end

    def get_dups
      puts 'Allow Duplicates, Enter Y or N'
      while true
        input = gets.chomp
        return input.downcase == 'y' if %w[y n].include?(input.downcase)
  
        puts 'Invalid Input, please try again'
  
      end
    end
    
    def get_guess(length)
      colors = %w[red green blue yellow brown orange black white]
  
      while true
        guess = gets.chomp.split(/\s+/)
  
        if guess.all? { |item| colors.include?(item.downcase) } && guess.length == length
          return guess
        elsif guess.length < length
          puts 'Too few colors'
        elsif guess.length > length
          puts 'Too many colors'
        else
          puts 'Invalid input, please try again'
        end
      end
    end
  
    def show_colors
      puts 'Colors = Red, Green, Blue, Yellow, Brown, Orange, Black, White'
    end
    
    def display_results(results)
      puts("Correct Colors: #{results[0]}\nCorrect placements: #{results[1]}")
    end
  end
  
  class Game
  
    def game
      while true
        play
        if play_again?
          puts 'Thanks for playing'
          break
        end
      end
    end
  

    def play
     
      initialize
      puts 'Welcome to Mastermind'
      length = @interface.get_code
      dups = @interface.get_dups
      code = if dups
               @board.init_Dups(length)
             else
               @board.init_NoDups(length)
             end
 
      puts "\nEnter your guess in the form of a code separated by spaces (for example: Red Green Blue Yellow)\n"
      for i in 0..7
        @interface.show_colors
        puts "Guesses : #{8 - i}"
        guess = @interface.get_guess(length)
        guess = @board.encode(guess)
        results = @board.integrate(code, guess)
  
        @interface.display_results(results)
        
        if results[1] == length
          puts 'Congradulations You Win'
          break
        end
  
        if i == 7
          puts "You lose\n"
          print "The code was #{@board.decode(code)}"
        end
      end
    end
  
    private
    def initialize
      @board = Board.new
      @interface = Interface.new
    end
    def continue
      puts 'Play again?, Enter Y or N'
      while true
        input = gets.chomp
        return input.downcase != 'y' if %w[y n].include?(input.downcase)
  
        puts 'Invalid Input, please try again'
  
      end
    end
  end
  
  game = Game.new
  game.game
  
