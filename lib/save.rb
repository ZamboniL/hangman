# frozen_string_literal: true

# The save class for saving and loading from yaml files
# it contains the important info for the game to start at
# any point
class Save
  attr_accessor :word, :hints, :incorrect, :lives

  def initialize(word, hints, incorrect, lives)
    @word = word
    @hints = hints
    @incorrect = incorrect
    @lives = lives
  end
end
