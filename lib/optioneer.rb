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

      # save the comand line passed to the program.
      @options[:cmdline] = ARGV.clone
      # save a tweaked version for internal usage.
      @options[:cmd_tweaked] = tweak_cmd(ARGV)

      # array to hold the EXPECTED comamnd line options
      @expected_options = []
      # hash to hold the named PASSED command line options
      @passed_options = {}
    end

    # Start parsing the command line, return it in a format that is easy to use.
    def parse
      @options[:cmd_tweaked].each_with_index do |opt, index|
        if opt.match(/^-/)
          # found a switch, is it long?
          if opt.match(/^--/)
            find_option(opt.gsub(/^--/, ''), :long)
          else
            find_option(opt.gsub(/^-/, ''), :short)
          end
        # if we are not a switch, must be an action, but only if last item.
        elsif index == @options[:cmd_tweaked].count - 1
          @options[:action] = opt
        end
      end
      @passed_options.count
    end

    def action
      @options[:action]
    end

    # allow setting of the help display banner
    def banner=(banner)
      @options[:banner] = banner
    end

    # return the current help display banner
    def banner
      @options[:banner]
    end

    # returns the original un-parsed command line passed to the program
    def cmdline
      @options[:cmdline]
    end

    # Add a new option to the list, assuming it does not already exist.
    def add(name, options = {})
      unless find_opt_by_name(name)
        new_option = Option.new(name, options)
        @expected_options.push(new_option)
        return new_option
      end
      fail 'You Cannot create 2 options with the same name.'
    end

    # return the named passed option
    def [](name)
      @passed_options[name]
    end

    # return the count of EXPECTED options
    def count
      @expected_options.count
    end

    private

    # adjust the command line to lump any short-form arguments together
    def tweak_cmd(cmd_line)
      cmd_line.each_with_index do |arg, index|
        next unless arg.match(/^-[A-Za-z0-9]$/)
        # we have a short form, see if there is an argument next in the array
        next if cmd_line[index + 1].match(/^-/)
        # there is so we merge the 2 parts, with '=' between them
        cmd_line[index] = "#{cmd_line[index]}=#{cmd_line[index + 1]}"
        cmd_line.delete_at(index + 1)
      end
    end

    # searches for a match in the expected options.
    def find_option(opt, which)
      # loop through all options and see if we have a match
      @expected_options.each do |expected|
        # we need to test first if an argument is included...
        the_opt = opt
        the_opt, the_arg = opt.split('=') if opt =~ /\=/
        next unless the_opt == expected.values[which]
        new_option = Option.new(expected.name)
        which == :long ? new_option.long = the_opt : new_option.short = the_opt
        new_option.argument = the_arg
        # check for both short and long options and fail if so
        check_duplicate(expected)
        @passed_options[expected.name] = new_option
      end
    end

    def check_duplicate(expected)
      if @options[:cmd_tweaked] =~ /--#{expected.values[:long]}/ &&
         @options[:cmd_tweaked] =~ /-#{expected.values[:short]}/
        fail 'You cannot combine both long and short versions of an option!'
      end
    end

    # Given a name, will return the object if the matching Option exists.
    def find_opt_by_name(name)
      @expected_options.each do |opt|
        return opt if opt.name == name
      end
      false
    end
  end
end
