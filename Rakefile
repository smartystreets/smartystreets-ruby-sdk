require 'bundler/gem_tasks'
require 'rake/testtask'

desc 'Run tests'
task default: :test

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/test_*.rb'
end
