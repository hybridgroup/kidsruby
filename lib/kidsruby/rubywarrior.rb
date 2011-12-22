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

  class Game
    def verify_setup
      make_game_directory unless File.exist?(Config.path_prefix + '/rubywarrior')
    end
  end
end

