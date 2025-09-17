require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

Dir[File.join(__dir__, 'test_*.rb')].each { |file| require file }
