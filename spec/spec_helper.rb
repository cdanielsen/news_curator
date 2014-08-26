require 'rspec'
require 'pg'
require 'pry'
require 'source'
require 'category'

DB = PG.connect({dbname: 'news_curator_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM sources *;")
    DB.exec("DELETE FROM categorys *;")
    DB.exec("DELETE FROM categorys_sources *;")
  end
end
