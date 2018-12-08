# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  add_filter "test"
end

require "minitest/autorun"
require "minitest/reporters"

reporter_options = { color: true }
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

module TestHelper
  TESTS_DIR = __dir__
  SUPPORT_DIR = File.join TESTS_DIR, "support"
end
