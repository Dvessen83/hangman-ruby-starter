require File.expand_path('../random_word', __FILE__)
require File.expand_path('../visuals', __FILE__)

class Hangman
    def initialize
        @random_word = RandomWord.new
        @bad_guesses_left = 10
    end

    # Welcome message
    # Show the amount of dashes of the random word
    def play!
        puts 'Welcome to Hangman!'
        word_to_dashes
        until @bad_guesses_left == 0
          option_menu
        end
        puts 'Game Over!'
    end

    # ask user for input a) letter b) whole word
    def option_menu
        puts "What would you like to do? Choose wisely, you can only make #{@bad_guesses_left} more mistakes. \n 1) Guess a letter? \n 2) Guess the whole word? \n 3) Exit game"
        answer = gets.chomp.to_i

        if answer == 1
            guess_letter
        elsif answer == 2
            guess_word
        elsif answer == 3
            puts 'Game Over.'
            exit
        else
            puts 'This is not a valid choice, try again.'
            option_menu
        end
    end

    def guess_letter
        print "Enter letter: "
        answer = gets.chomp.downcase
        if @random_word.word.include? answer
          puts "We have a match!"
          correct_letter(answer)
          update_dashed_word(answer)
        else
          wrong_answer
        end
    end

    def guess_word
        print "Enter word: "
        answer = gets.chomp.downcase
        if answer == @random_word.word
          puts "Congratulations! You guessed right! \nThank you for playing Hangman"
          exit
        else
          wrong_answer
        end
    end

    def word_to_dashes
      @dashed_word = ("-"*@random_word.word.length).chars
      puts "This will be the your word: #{@dashed_word.join}"
    end

    def correct_letter(letter)
      @index_array = []
      word_array = @random_word.word.chars
      @index_array = word_array.each_index.select { |i| word_array[i] == letter }
    end

    def update_dashed_word(answer)
      @index_array.each do |element|
        @dashed_word[element] = answer
      end
      puts "Updated word: #{@dashed_word.join}"
    end

    def wrong_answer
      @bad_guesses_left -= 1
      if @bad_guesses_left == 0
        puts "Wrong answer again."
        Visuals.new.game_over
        exit
      else
        puts "Bad choice! Guesses left before you hang: #{@bad_guesses_left}."
        Visuals.new.gallow(@bad_guesses_left)
      end
    end


end
