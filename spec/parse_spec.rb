# rubocop:disable LineLength
require 'spec_helper'

describe Optioneer do
  subject { Optioneer::Optioneer.new }

  # clear the current ARGV and add our own test cases
  before(:each) do
    ARGV.clear
    @cmd = %w(-r --quiet action)
    (ARGV << @cmd).flatten!
  end

  it 'stores the given command line when created' do
    expect(subject.cmdline).to eq @cmd
  end
end
