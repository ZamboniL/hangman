# frozen_string_literal: true

require_relative 'display'
require_relative 'save_manager'
require_relative 'dictionary'
# Main game functionalities, defines the start of the game, the loop,
# win condition and lose condition
class Game
  attr_reader :word

  include Dictionary
  include SaveManager
  def initialize
    @word = pick_a_word
    @hints = Array.new(@word.length, '_')
    @incorrect = []
    @lives = 0
  end

  def start
    Display.title
    Display.about
    print 'Type anything to start a new game or "load" to load your save: '
    option = gets.chomp.downcase
    configure_save if option == 'load'
    game_loop
  end

  private

  # Loads the save the player selected into the
  # Game class variables
  def configure_save
    save = load_save
    @word = save.word
    @hints = save.hints
    @incorrect = save.incorrect
    @lives = save.lives
  end

  # Game loop and win or lose conditions check
  def game_loop
    loop do
      current_state

      Display.win(@word) if win_condition
      Display.lose(@word) if lose_condition
      break if win_condition || lose_condition

      ask_letter
    end
  end

  # Display the current state of the game board
  def current_state
    Display.hangman(@lives)
    puts @hints.join('.')
    Display.errors(@incorrect)
  end

  # asks the player to either type in a guess or the save command
  def ask_letter
    letter = Display.ask
    if letter == 'save'
      save_game
      ask_letter
    end
    word_check = @word.map(&:clone)
    check_if_correct(word_check, letter)
  end

  # Save the game
  def save_game
    create_save(@word, @hints, @incorrect, @lives)
  end

  # Check for the player guess, if it is correct
  # the guess will be correctly placed on the hints
  # array
  def check_if_correct(word, letter)
    if word.include?(letter)
      index = word.index(letter)
      word[index] = '' # Clear the letter from word so it can check for other instances of letter
      @hints[index] = letter
      check_if_correct(word, letter) # It will loop through every instace of letter on word
    elsif !@hints.include?(letter)
      @incorrect.push(letter) unless @incorrect.include?(letter)
      @lives += 1
    end
  end

  def win_condition
    @word == @hints
  end

  def lose_condition
    @lives == 6
  end
end
