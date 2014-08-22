require 'spec_helper'

describe Source do

  describe 'initialize' do
  	it 'is initialized with a hash of attributes' do
      test_source = Source.new({name: 'NYTimes', url: 'nytimes.com'})
      expect(test_source).to be_a Source
    end
  end

  describe ".all" do
    it 'shows all news sources currently saved in the database' do
      test_source1 = Source.new({name: 'NYTimes', url: 'nytimes.com'})
      test_source2 = Source.new({name: 'HuffPost', url: 'huffpost.com'})
      test_source1.save
      test_source2.save
      expect(Source.all).to eq [test_source1, test_source2]
    end
  end

  describe '#save' do
    it 'lets you save a news source to the database' do
      test_source = Source.new({name: 'NYTimes', url: 'nytimes.com'})
      test_source.save
      expect(Source.all).to eq [test_source]
    end
  end

  describe '==' do
    it 'is the same source if it has the same name and url' do
      test_source1 = Source.new({name: 'NYTimes', url: 'nytimes.com'})
      test_source2 = Source.new({name: 'NYTimes', url: 'nytimes.com'})
      expect(test_source1).to eq test_source2
    end
  end

  describe '#id' do
    it 'tells you its id in the database' do
      test_source1 = Source.new({name: 'NYTimes', url: 'nytimes.com'})
      test_source1.save
      expect(test_source1.id).to be_a Fixnum
    end
  end

  describe '#add_category' do
    it 'assigns a category_id to the news source' do
      test_source1 = Source.new({name: 'NYTimes', url: 'nytimes.com'})
      test_source1.save
      test_source1

end
