require_relative "../spec_helper"
require_relative "../../lib/kidsruby/stdio"
require_relative "../../lib/kidsruby/rubywarrior"

describe 'rubywarrior' do
  describe 'Game' do
    it "must be able to start" do
      RubyWarrior::Game.any_instance.expects(:verify_setup).returns(nil)
      RubyWarrior::Game.any_instance.expects(:start).returns(nil)
      RubyWarrior.play
    end

    it "must be able to verify setup where no game directory exists yet" do
      File.expects(:exist?).returns(false)
      RubyWarrior::Game.any_instance.expects(:make_game_directory).returns(nil)
      RubyWarrior::Game.new.verify_setup
    end

    it "must be able to prepare the next level" do
      @next_level = mock("level")
      @next_level.expects(:show_description).returns(nil)
      RubyWarrior::Game.any_instance.expects(:next_level).returns(@next_level)
      RubyWarrior::Game.any_instance.expects(:prepare_next_level_original).returns(nil)
      RubyWarrior::Game.new.prepare_next_level
    end
  end

  describe 'Level' do
    before do
      @profile = mock('profile')
      @level = RubyWarrior::Level.new(@profile, 1)
    end

    it "must not load player from file" do
      @level.expects(:load).never
      @level.load_player
    end

    it "must be able to show description" do
      @level.expects(:load_level)
      RubyWarrior::PlayerGenerator.any_instance.expects(:show_description)
      RubyWarrior::UI.expects(:puts)
      @level.show_description
    end
  end

  describe 'PlayerGenerator' do
    it "must be able to show description" do
      @level = mock('level')
      RubyWarrior::PlayerGenerator.any_instance.expects(:read_template)
      RubyWarrior::PlayerGenerator.new(@level).show_description
    end
  end

end

