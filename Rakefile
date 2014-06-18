#!/usr/bin/env rake
require 'dotenv'
require 'rspec/core/rake_task'
Dotenv.load(ENV['RACK_ENV'] == 'test' ? '.env.test' : '.env')

require './app'
require 'json'

Dir.glob('./lib/tasks/*.rake').each { |r| import r }


RSpec::Core::RakeTask.new(:spec)
task default: :spec
