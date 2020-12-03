# frozen_string_literal: true

# Dictionary module, only function is to load the entire dictionary and
# then pick a random word from it, that will be the word the player has to guess
module Dictionary
  def pick_a_word
    @file = File.readlines 'data/dictionary.txt' if File.readable? 'data/dictionary.txt'
    word = @file[rand(@file.length - 1)].strip.downcase.chars
    pick_a_word if word.length < 5 || word.length > 12
    word
  end
end
