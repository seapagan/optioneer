require 'optioneer/version'
require 'optioneer/option'

# A self-contained interface to the command line
module Optioneer
  # Main control class
  class Optioneer
    # Hash containing any options we want to define as defaults if not specified
    DEFAULT_OPTIONS = {}.freeze

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
      @options[:expected] = []
      # hash to hold the named PASSED command line options
      @options[:passed] = {}
    end

    # Start parsing the command line, return it in a format that is easy to use.
    # @example
    #   option = Optioneer::Optioneer.new
    #   option.parse
    # @return [fixnum] Count of flags and actions on the command line
    def parse
      @options[:cmd_tweaked].each_with_index do |opt, index|
        if opt =~ /^-/
          # found a switch, is it long?
          opt =~ /^--/ ? find_option(opt, :long) : find_option(opt, :short)
        # if we are not a switch, must be an action, but only if last item.
        elsif index == @options[:cmd_tweaked].count - 1
          @options[:action] = opt
        end
      end
      @options[:passed].count unless check_duplicate
    end

    # return the 'action' assiciated with the command line
    # @return [string] The action requested on the command line
    def action
      @options[:action]
    end

    # allow setting of the help display banner
    # @param banner [string] The text banner to be shown with help, version, etc
    # @example
    #   option = Optioneer::Optioneer.new
    #   option.banner = 'My fabulous application!'
    # @return [string] The specified banner string
    def banner=(banner)
      @options[:banner] = banner
    end

    # return the current help display banner
    # @param [none]
    # @return [string] The previously set banner
    # @example
    #   option = Optioneer::Optioneer.new
    #   option.banner = 'My fabulous application!'
    #   option.banner
    #   => 'My fabulous application!'
    def banner
      @options[:banner]
    end

    # allow setting the version string
    # @param version [string] The version string
    # @example
    #   option = Optioneer::Optioneer.new
    #   option.version = '1.2.3'
    # @return [string] The specified version string
    def version=(version)
      @options[:version] = version
    end

    # return the current version string
    # @param [none]
    # @return [string] The previously set version
    # @example
    #   option = Optioneer::Optioneer.new
    #   option.version = '1.2.3'
    #   option.version
    #   => '1.2.3'
    def version
      @options[:version]
    end

    # returns the original un-parsed command line passed to the program
    def cmdline
      @options[:cmdline]
    end

    # Add a new option to the list, assuming it does not already exist.
    # @param name [string] OPTIONAL name of this option
    # @param options [hash] OPTIONAL hash containing the new option settings
    # @return [Class] Returns the instance of the newly created option
    def add(name, options = {})
      unless find_opt_by_name(name)
        new_option = Option.new(name, options)
        @options[:expected].push(new_option)
        return new_option
      end
      raise 'You Cannot create 2 options with the same name.'
    end

    # return the named passed option
    # @param name [string] The name of the parameter to query
    # @return [string] options with this name
    def [](name)
      @options[:passed][name]
    end

    # return the count of EXPECTED options
    # @param [none]
    # @return [fixnum] Number of different options we EXPECT
    # @example
    #   option.count
    #   => 4
    def count
      @options[:expected].count
    end

    private

    # adjust the command line to lump any short-form arguments together
    def tweak_cmd(cmd_line)
      cmd_line.each_with_index do |arg, index|
        next unless arg =~ /^-[A-Za-z0-9]$/
        # we have a short form, see if there is an argument next in the array
        next if cmd_line[index + 1] =~ /^-/
        # there is so we merge the 2 parts, with '=' between them
        cmd_line[index] = "#{cmd_line[index]}=#{cmd_line[index + 1]}"
        cmd_line.delete_at(index + 1)
      end
    end

    # searches for a match in the expected options.
    def find_option(opt, which)
      # loop through all options and see if we have a match
      @options[:expected].each do |expected|
        # we need to test first if an argument is included...
        (the_opt, the_arg) = opt.delete('-').split('=')
        next unless the_opt == expected.values[which]
        new_option = Option.new(expected.name)
        which == :long ? new_option.long = the_opt : new_option.short = the_opt
        # if an arg exists, add this to the option data
        new_option.argument = the_arg if the_arg
        # add the newly decoded option to the list
        @options[:passed][expected.name] = new_option
      end
    end

    def check_duplicate
      # determine if we have both short and long form of the same option,
      # and raise error if so.
      cmdline.each do |opt|
        next unless opt =~ /^--/
        short = "-#{get_short_from_long(opt.delete('-'))}"
        next unless @options[:cmdline].include?(short)
        raise 'You cannot combine both long and short versions of an option!'
      end
      false
    end

    # Given a name, will return the object if the matching Option exists.
    def find_opt_by_name(name)
      @options[:expected].each do |opt|
        return opt if opt.name == name
      end
      false
    end

    # given a long option will get the matching short
    def get_short_from_long(long)
      @options[:expected].each do |opt|
        return opt.values[:short] if opt.values[:long] == long
      end
      nil
    end
  end
end
