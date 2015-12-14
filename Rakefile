require 'bundler/gem_tasks'

desc "Default task"
task default: :spec

desc "Open an irb session preloaded with this library"
task :console do
  exec 'irb -r money_conversion -I ./lib'
end

desc "Run specs"
task :spec do
  system "rspec ."
end