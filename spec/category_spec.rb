require 'spec_helper'

describe Category do

  describe 'initialize' do
    it 'is initialized with a hash of attributes' do
      test_category = Category.new({slant: 'leftie'})
      expect(test_category).to be_a Category
    end
  end


end
