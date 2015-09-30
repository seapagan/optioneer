require 'optioneer/version'
require 'optioneer/option'

# A self-contained interface to the command line
module Optioneer
  # Main control class
  class Optioneer
    # Hash containin any options we want to define as defaults of not specified
    DEFAULT_OPTIONS = {}

    # Setup the class with specified parameters or default values if any or all
    # are absent.
    # All parameters are optional.
    # @param options [Hash] Hash value containing any passed parameters.
    def initialize(options = {})
      @options = DEFAULT_OPTIONS.merge(options)
      # set all other unset options to return false instead of Nul.
      @options.default = false
    end
  end
end
