require 'ruby_warrior'
require 'tmpdir'

# various monkey patches needed to get rubywarrior working within kidsruby environment
module RubyWarrior
  Config.in_stream = StdIn.new
  Config.out_stream = $stdout
  Config.delay = 0.6
  Config.path_prefix = Dir.tmpdir

  def self.play
    game = Game.new
    game.verify_setup
    game.start
  end

  class Game
    def verify_setup
      make_game_directory unless File.exist?(Config.path_prefix + '/rubywarrior')
    end

    alias_method :prepare_next_level_original, :prepare_next_level
    def prepare_next_level
      prepare_next_level_original
      next_level.show_description
    end
  end

  class Level
    # do not load player class from rubywarrior directory, because it should be in kidsruby editor
    def load_player; end

    def show_description
      load_level
      UI.puts PlayerGenerator.new(self).show_description
    end
  end

  class PlayerGenerator
    def show_description
      read_template(templates_path + '/README.erb')
    end
  end

end

