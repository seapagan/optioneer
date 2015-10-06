module Optioneer
  # an instance will be created for each individual option registered or passed.
  class Option
    attr_reader :name
    def initialize(name = '', options = {})
      @name = name
      @data = options
    end

    def short=(short_form)
      @data[:short] = short_form
    end

    def long=(long_form)
      @data[:long] = long_form
    end

    def argument=(argument)
      @data[:arg] = argument
    end

    def help=(help)
      @data[:help] = help
    end

    def values
      @data
    end
  end
end
