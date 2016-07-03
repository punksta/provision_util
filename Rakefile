require 'bundler/gem_tasks'
task :default => :spec

task :console do
  require 'irb'
  require 'irb/completion'
  require 'lib/provision_util'
  ARGV.clear
  IRB.start
end
