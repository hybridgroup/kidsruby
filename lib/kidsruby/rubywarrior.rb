require 'ruby_warrior'

module RubyWarrior
  Config.in_stream = StdIn.new
  Config.out_stream = $stdout
  Config.delay = 0.6
  Config.path_prefix = File.expand_path(File.dirname(__FILE__) + "../../..") 

  def self.play
    game = RubyWarrior::Game.new
    game.verify_setup
    game.start
  end

  # just generate the .profile file as needed
  class Game
    def verify_setup
      make_game_directory unless File.exist?(Config.path_prefix + '/rubywarrior')
    end

    alias_method :prepare_next_level_original, :prepare_next_level
    def prepare_next_level
      prepare_next_level_original
      next_level.display_description
    end
  end

  # do not load player class from rubywarrior directory, because it should be in kid's editor
  class Level
    def load_player; end

    def display_description
      load_level
      UI.puts PlayerGenerator.new(self).level_description
    end
  end

  class PlayerGenerator
    def level_description
      read_template(templates_path + '/README.erb')
    end
  end

end

