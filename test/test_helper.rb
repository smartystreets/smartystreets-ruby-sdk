require 'simplecov'
SimpleCov.start do
  enable_coverage :branch
  add_filter '/test/'
  track_files 'lib/**/*.rb'
end

at_exit do
  puts "Loaded files:"
  puts $LOADED_FEATURES.grep(/smartystreets_ruby_sdk/)
end

require 'minitest/autorun'
$LOAD_PATH.unshift File.expand_path(__dir__) 