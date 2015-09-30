module Optioneer
  # This class will be instantiated for each individual
  class Option
    attr_reader :name
    def initialize(name)
      @name = name
      @data = {}
    end

    def short=(short_form)
      @data[:short_form] = short_form
    end

    def long=(long_form)
      @data[:long_form] = long_form
    end

    def argument=(argument)
      @data[:argument] = argument
    end

    def help=(help)
      @data[:help] = help
    end

    def values
      @data
    end
  end
end
