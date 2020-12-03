# frozen_string_literal: true

require_relative 'save'
# Game's save functionalities
module SaveManager
  # Create a new save file
  def create_save(word, hints, incorrect, lives)
    save = Save.new(word, hints, incorrect, lives).to_yaml
    print 'Save name: '
    file_name = gets.chomp
    File.open("saves/#{file_name}.yaml", 'w+') do |file|
      file.puts save
    end
    puts 'Save created successfully!'
  end

  # Load the file back into a Save object
  def load_save
    file_name = ask_save
    save_obj = {}
    File.open("saves/#{file_name}.yaml", 'r') do |file|
      save_obj = YAML.safe_load(file, permitted_classes: [Save])
    end
    save_obj
  end

  # Ask user for which of the current save files he needs to load
  def ask_save
    print "Current save files are:\n\n"
    print "\e[34m#{save_names.join("\n")}\e[0m\n\n"
    print 'Which one is your save? '
    save = gets.chomp
    if save_names.include?(save)
      puts 'Save loaded successfully'
      return save
    end
    error_message
    ask_save
  end

  # For invalid load requests
  def error_message
    puts "\e[41mNot a valid save name.\e[0m\n\n"
  end

  # file names on the saves directory
  def save_names
    saves = Dir.entries('saves').select { |f| f.include? 'yaml' }
    no_saves_error if saves.empty?
    saves.map { |f| f.gsub('.yaml', '') }
  end

  def no_saves_error
    puts 'No available saves, restart the game.'
  end
end
