# frozen_string_literal: true

# Display is most of the console outputs condensed into a class
class Display
  def self.title
    puts "          _______  _        _______  _______  _______  _
|\\     /|(  ___  )( (    /|(  ____ \\(       )(  ___  )( (    /|
| )   ( || (   ) ||  \\  ( || (    \\/| () () || (   ) ||  \\  ( |
| (___) || (___) ||   \\ | || |      | || || || (___) ||   \\ | |
|  ___  ||  ___  || (\\ \\) || | ____ | |(_)| ||  ___  || (\\ \\) |
| (   ) || (   ) || | \\   || | \\_  )| |   | || (   ) || | \\   |
| )   ( || )   ( || )  \\  || (___) || )   ( || )   ( || )  \\  |
|/     \\||/     \\||/    )_)(_______)|/     \\||/     \\||/    )_)\n\n\n"
  end

  def self.about
    puts "\e[01mAbout the game:\e[0m
In this version of Hangman the player has to guess letters from a secret word
picked randomly from a dictionary, if he guesses incorrectly 6 times the game is
over, and if the player guets every character of the word he wins.\n\n\n"
  end

  # Goddam hangman doll, i don't have a clue how to
  # condense this better and rubocop freaks out about
  # it, but the doll stays!!
  def self.hangman(lives)
    print "\n\n|--|\n|  "
    puts lives >= 1 ? 'o' : "\n"
    print lives < 2 ? "|\n" : '|'
    print "  I\n" if lives == 2
    print " /I\n" if lives == 3
    print " /I\\ \n" if lives > 3
    print '|'
    print ' /' if lives == 5
    puts ' / \\' if lives == 6
    puts
  end

  def self.ask
    print 'Type a letter, or type "save" if you want to save the game: '
    letter = gets.chomp.downcase
    return ask unless valid?(letter)

    letter
  end

  def self.errors(array)
    puts "Your incorrect guesses are: \e[31m#{array.join(', ')}\e[0m"
  end

  def self.valid?(letter)
    letter.length == 1 && /([a-zA-z])/.match?(letter) || letter == 'save'
  end

  def self.lose(word)
    puts "\e[31mYou Lost! :(  The word was: #{word.join}\e[0m"
  end

  def self.win(word)
    puts "\e[32mYou Won!! With the word: #{word.join}\e[0m"
  end
end
