require File.expand_path('../random_word', __FILE__)

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
        option_menu
        puts 'This is what comes next'
    end

    # ask user for input a) letter b) whole word
    def option_menu
        puts "What would you like to do? Choose wisely, you can only make #{@bad_guesses_left} (more) mistakes. \n 1) Guess a letter? \n 2) Guess the whole word? \n 3) Exit game"
        answer = gets.chomp.to_i

        if answer == 1
            puts "Your answer #{answer}"
            guess_letter
        elsif answer == 2
            puts "Your answer #{answer}"
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
        else
          @bad_guesses_left -= 1
          puts "Bad choice! Only #{@bad_guesses_left} mistakes before you hang!"
        end
    end

    def guess_word
        print "Enter word: "
        answer = gets.chomp.downcase
        if answer == @random_word.word
          puts "Congratulations! You guessed right! \nThank you for playing Hangman"
        else
          @bad_guesses_left -= 1
          puts "Bad choice! Only #{@bad_guesses_left} mistakes before you hang!"
        end
    end

    def word_to_dashes
      puts "Your word #{@random_word.word}"
      @dashed_word = "-"*@random_word.word.length
      puts "This will be the your word: #{@dashed_word}" 
    end


end
