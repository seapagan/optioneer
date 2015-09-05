require 'spec_helper'

describe Optioneer do
  it 'has a version number' do
    expect(Optioneer::VERSION).not_to be nil
  end

  it 'should create an instance of the class with no errors' do
    expect(subject).to be_a Optioneer
  end
end
