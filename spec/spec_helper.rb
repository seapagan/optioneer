$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'should_not/rspec'
require 'simplecov'
require 'pullreview/coverage'
require 'coveralls'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter,
  PullReview::Coverage::Formatter
]
SimpleCov.start

require 'optioneer'
