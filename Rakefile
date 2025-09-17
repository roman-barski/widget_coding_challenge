# frozen_string_literal: true

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test_*.rb']
  t.verbose = true
end

desc 'Run all tests'
task default: :test

desc 'Run the demo'
task :demo do
  exec 'ruby demo.rb'
end

desc 'Run tests with coverage'
task :test_with_coverage do
  exec 'ruby test/test_runner.rb'
end
