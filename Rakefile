#!/usr/bin/env rake

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'bundler/gem_tasks'

##
# Configure the test suite.
##
require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new

##
# Cucumber for feature testing.
##
require 'rake/clean'
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = 'features --format pretty -x'
  t.fork = false
end

##
# By default, just run the tests.
##
task default: :spec
