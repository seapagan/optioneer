# rubocop:disable LineLength
require 'spec_helper'
require 'yaml'

describe Optioneer do
  subject { Optioneer::Optioneer.new }

  # clear the current ARGV and add our own test cases
  before(:each) do
    ARGV.clear
    # this should return 4 switches (2 with options) and one action
    @cmd = %w(-r --quiet --switch=option -d directory action)
    (ARGV << @cmd).flatten!
    # create specs to validate these
    subject.add(:one, short: 'r', long: 'recurse')
    subject.add(:two, short: 'q', long: 'quiet')
    subject.add(:three, short: 's', long: 'switch', arg: 'OPTION')
    subject.add(:four, short: 'd', arg: 'DIRECTORY')
  end

  it 'stores the given command line when created' do
    expect(subject.cmdline).to eq @cmd
  end

  context 'when parsing the command line' do
    it 'returns the correct number of switches (long or short)' do
      expect(subject.parse).to eq 4
    end
    it 'returns any specified arguments to switches' do
      subject.parse
      expect(subject[:three].values[:arg]).to eq 'option'
      expect(subject[:four].values[:arg]).to eq 'directory'
    end
    it 'will not allow both the short and long form' do
      ARGV.clear
      # this should return 4 switches (2 with options) and one action
      @cmd = %w(-r --recurse --quiet --switch=option -d directory action)
      (ARGV << @cmd).flatten!
      # create opbect
      opts = Optioneer::Optioneer.new
      # create specs to validate these
      opts.add(:one, short: 'r', long: 'recurse')
      opts.add(:two, short: 'q', long: 'quiet')
      opts.add(:three, short: 's', long: 'switch', arg: 'OPTION')
      opts.add(:four, short: 'd', arg: 'DIRECTORY')
      expect { opts.parse }.to raise_error(RuntimeError, 'You cannot combine both long and short versions of an option!')
    end
    skip 'will only allow registered options' do
    end
    it 'returns the action specified' do
      subject.parse
      expect(subject.action).to eq 'action'
    end
  end
end
