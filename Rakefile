begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

require "bundler/gem_tasks"

##
# Configure the test suite.
##
require "rspec/core"
require "rspec/core/rake_task"

task(:spec).clear
desc "Run specs other than spec/acceptance"
RSpec::Core::RakeTask.new("spec") do |task|
  task.exclude_pattern = "spec/acceptance/**/*_spec.rb"
  task.verbose = false
end

desc "Run acceptance specs in spec/acceptance"
RSpec::Core::RakeTask.new("spec:acceptance") do |task|
  task.pattern = "spec/acceptance/**/*_spec.rb"
  task.verbose = false
end

desc "Run the specs and acceptance tests"
task default: %w(spec spec:acceptance)
