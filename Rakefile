# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://guides.rubygems.org/specification-reference/ for more options
  gem.name = "locamotion"
  gem.homepage = "http://github.com/incbee/locamotion"
  gem.license = "MIT"
  gem.summary = %Q{CLI tool to generate localizable files in RubyMotion projects}
  gem.description = %Q{Locamotion (Localization Motion) is a Command Line tool to generate localizable files in RubyMotion projects. It parses the 'app' directory for SugarCube (https://github.com/rubymotion/sugarcube) strings, ending in '._'. It also transfers the english localized files into others.}
  gem.email = "ramon.martin.huidobro@gmail.com"
  gem.authors = ["Ramon Huidobro"]
  gem.executables = ['locamotion']
  gem.files.include %w(lib/**/*.rb)
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

desc "Code coverage detail"
task :simplecov do
  ENV['COVERAGE'] = "true"
  Rake::Task['spec'].execute
  Rake::Task['features'].execute
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features)

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "locamotion #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
