$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'rspec/core/rake_task'
require 'arcserver/version'
require "bundler/gem_tasks"

task :console do
  ARGV.clear
  require 'arcserver'
  require 'irb'
  IRB.start
end

task :default => :spec
task :test => :spec

RSpec::Core::RakeTask.new('spec')
