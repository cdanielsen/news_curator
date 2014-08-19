require 'spec_helper'

describe Source do
  describe 'initialize' do
  	it 'is initialized with a hash of attributes' do
      new_source = Source.new({name: 'NYTimes', url: 'nytimes.com'})
      expect(new_source).to be_a Source
    end
  end
end