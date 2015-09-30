require 'spec_helper'

describe Optioneer do
  subject { Optioneer::Optioneer }
  it 'has a version number' do
    expect(Optioneer::VERSION).not_to be nil
  end

  let(:options) { subject.new }
  it 'should create an instance of the class with no errors' do
    expect(options).to be_an_instance_of subject
  end
  context 'adding new command line options' do

  end
end
