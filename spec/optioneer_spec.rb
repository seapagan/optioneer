require 'spec_helper'

describe Optioneer do
  subject { Optioneer::Optioneer }
  it 'has a version number' do
    expect(Optioneer::VERSION).not_to be nil
  end
  it 'creates an instance of the class with no errors' do
    expect(subject.new).to be_an_instance_of subject
  end
  context 'adding new command line options' do
  end
end
