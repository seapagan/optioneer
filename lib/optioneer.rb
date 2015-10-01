require 'optioneer/version'
require 'optioneer/option'

# A self-contained interface to the command line
module Optioneer
  # Main control class
  class Optioneer
    # Hash containing any options we want to define as defaults if not specified
    DEFAULT_OPTIONS = {}

    # Setup the class with specified parameters or default values if any or all
    # are absent.
    # All parameters are optional.
    # @param options [Hash] Hash value containing any passed parameters.
    def initialize(options = {})
      @options = DEFAULT_OPTIONS.merge(options)
      # set all other unset options to return false instead of Nul.
      @options.default = false

      @command_options = []
    end

    # Add a new option to the list, assuming it does not already exist.
    def add(name)
      unless find_opt_by_name(name)
        new_option = Option.new(name)
        @command_options.push(new_option)
        return new_option
      end
      fail 'You Cannot create 2 options with the same name.'
    end

    def count
      @command_options.count
    end

    private

    # Given a name, will return details of the matching Option.
    def find_opt_by_name(name)
      @command_options.each do |opt|
        return true if opt.name == name
      end
      false
    end
  end
end
