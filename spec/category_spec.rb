require 'spec_helper'

describe Category do

  describe 'initialize' do
    it 'is initialized with a hash of attributes' do
      test_category1 = Category.new({slant: 'leftie'})
      expect(test_category1).to be_a Category
    end
  end

  describe ".all" do
    it 'shows all categories currently saved in the database' do
      test_category1 = Category.new({slant: 'leftie'})
      test_category2 = Category.new({slant: 'right-of-center'})
      test_category1.save
      test_category2.save
      expect(Category.all).to eq [test_category1, test_category2]
    end
  end

  describe "#save" do
    it 'lets you save a category to the database' do
      test_category1 = Category.new({slant: 'leftie'})
      test_category1.save
      expect(Category.all).to eq [test_category1]
    end
  end

  describe '==' do
    it 'is the same category if it has the same slant' do
      test_category1 = Category.new({slant: 'leftie'})
      test_category2 = Category.new({slant: 'leftie'})
      expect(test_category1).to eq test_category2
    end
  end

  describe '#add_source' do
    it 'links a source to a category' do
      test_category1 = Category.new({slant: 'center_left'})
      test_category1.save
      test_source1 = Source.new({name: 'NYTimes', url: 'nytimes.com'})
      test_source1.save
      test_category1.add_source(test_source1)
      expect(test_category1.sources).to eq [test_source1]
    end
  end
end
