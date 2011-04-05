# rake tasks go here
task :default => :spec

task :spec do
  Dir[File.dirname(__FILE__) + "/spec/**/*_spec.rb"].each do |path|
    require path
  end

  MiniTest::Unit.autorun
end