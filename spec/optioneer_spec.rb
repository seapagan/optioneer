# rubocop:disable LineLength
require 'spec_helper'

describe Optioneer do
  subject { Optioneer::Optioneer }
  it 'has a version number' do
    expect(Optioneer::VERSION).not_to be nil
  end
  it 'creates an instance of the class with no errors' do
    expect(subject.new).to be_an_instance_of subject
  end
  it 'accepts a banner string for the help display' do
    banner_test = subject.new
    banner_test.banner = 'An exciting banner for this application!'
    expect(banner_test.banner).to eq 'An exciting banner for this application!'
  end
  context 'adding new command line options' do
    let(:opt) { subject.new }
    it 'will add a new named option' do
      new = opt.add(:test)
      expect(new.name).to be :test
    end
    it 'will count 1 option only' do
      opt.add(:test)
      expect(opt.count).to eq 1
    end
    it 'will count 3 options if we add 3' do
      opt.add(:test)
      opt.add(:test2)
      opt.add(:test3)
      expect(opt.count).to eq 3
    end
    it 'will not allow options with the same name' do
      opt.add(:test)
      expect { opt.add(:test) }.to raise_error(RuntimeError,
                                               'You Cannot create 2 options with the same name.')
      expect(opt.count).to eq 1
    end
    context 'with a new option, we can add the related information' do
      let(:newopt) { subject.new.add(:test) }
      it 'accepts a short-form (single letter) option' do
        newopt.short = 'r'
        expect(newopt.values[:short]).to eq 'r'
      end
      it 'accepts a long-form option' do
        newopt.long = 'recurse'
        expect(newopt.values[:long]).to eq 'recurse'
      end
      it 'accepts an argument' do
        newopt.argument = 'DEPTH'
        expect(newopt.values[:arg]).to eq 'DEPTH'
      end
      it 'accepts a help string' do
        newopt.help = 'Help string for this option'
        expect(newopt.values[:help]).to eq 'Help string for this option'
      end
      it 'will take all these as arguments to the initialize call' do
        multi_test = subject.new
        this_opt = multi_test.add(:test, short: 'r', long: 'recurse', arg: 'DEPTH', help: 'Help string for this option')
        expect(this_opt.values[:short]).to eq 'r'
        expect(this_opt.values[:long]).to eq 'recurse'
        expect(this_opt.values[:arg]).to eq 'DEPTH'
        expect(this_opt.values[:help]).to eq 'Help string for this option'
      end
    end
  end
end
