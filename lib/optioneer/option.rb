module Optioneer
  # an instance will be created for each individual option registered or passed.
  class Option
    # Read-only attribute which will return the internal name of this option
    # @attr_reader :name [string] internal name of this option
    attr_reader :name

    # constructor
    # @param name [string] OPTIONAL name of this option
    # @param options [hash] OPTIONAL hash containing the option settings
    def initialize(name = '', options = {})
      @name = name
      @data = options
    end

    # set the 'short form' flag for this option
    # @param short_form [string] The short form of this option
    # @return [string] The short form just set.
    def short=(short_form)
      @data[:short] = short_form
    end

    # set the 'long form' flag for this option
    # @param long_form [string] The long form of this option
    # @return [string] The long form just set.
    def long=(long_form)
      @data[:long] = long_form
    end

    # set the 'argument' for this option if appliciable
    # @param arguement [string] The arguement for the command
    # @example
    #   opt = Option.new(:test)
    #   opt.arguement = 'explode'
    # @return [string] The arguement just set.
    def argument=(argument)
      @data[:arg] = argument
    end

    # set the 'help text' flag for this option
    # @param help [string] The help text for this specific option
    # @return [string] The help text just set.
    def help=(help)
      @data[:help] = help
    end

    # this holds the full hash for that option
    # @param [none]
    # @return [hash] Hash containing all short/long etc for this option
    def values
      @data
    end
  end
end
