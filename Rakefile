# rake tasks go here
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs.push "spec"
  t.pattern = "spec/**/*_spec.rb"
  t.verbose = true
end

Dir[File.expand_path("../dist/**/*.rake", __FILE__)].each do |rake|
  import rake
end

## dist

require "erb"
require "fileutils"
require "tmpdir"

def assemble(source, target, perms=0644)
  FileUtils.mkdir_p(File.dirname(target))
  File.open(target, "w") do |f|
    f.puts ERB.new(File.read(source)).result(binding)
  end
  File.chmod(perms, target)
end

def assemble_distribution(target_dir=Dir.pwd)
  distribution_files.each do |source|
    target = source.gsub(/^#{project_root}/, target_dir)
    FileUtils.mkdir_p(File.dirname(target))
    FileUtils.cp(source, target)
  end
end

#GEM_BLACKLIST = %w( bundler kidsruby )

#def assemble_gems(target_dir=Dir.pwd)
#  lines = %x{ bundle show }.strip.split("\n")
#  raise "error running bundler" unless $?.success?
#
#  %x{ env BUNDLE_WITHOUT="development:test" bundle show }.split("\n").each do |line|
#    if line =~ /^  \* (.*?) \((.*?)\)/
#      next if GEM_BLACKLIST.include?($1)
#      puts "vendoring: #{$1}-#{$2}"
#      gem_dir = %x{ bundle show #{$1} }.strip
#      FileUtils.mkdir_p "#{target_dir}/vendor/gems"
#      %x{ cp -R "#{gem_dir}" "#{target_dir}/vendor/gems" }
#    end
#  end.compact
#end

def clean(file)
  rm file if File.exists?(file)
end

def distribution_files(type=nil)
#  type_files = type ?
#    Dir[File.expand_path("../{dist,spec}/**/*", __FILE__)] :
#    []
#  t = files - type_files
#  t
  files
end

def files
  Dir[File.expand_path("../**/*", __FILE__)].select do |file|
    File.file?(file)
  end
end


def mkchdir(dir)
  FileUtils.mkdir_p(dir)
  Dir.chdir(dir) do |dir|
    yield(File.expand_path(dir))
  end
end

def pkg(filename)
  FileUtils.mkdir_p("pkg")
  File.expand_path("../pkg/#{filename}", __FILE__)
end

def project_root
  File.dirname(__FILE__)
end

def resource(name)
  File.expand_path("../dist/resources/#{name}", __FILE__)
end
def version
  require File.expand_path("../app/models/version", __FILE__)
  KidsRuby::VERSION
end
def installedsize
  File.size?(File.expand_path("../pkg/data.tar.gz", __FILE__)) / 1024
end
