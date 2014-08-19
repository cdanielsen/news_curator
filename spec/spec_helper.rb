require 'rspec'
require 'source'
require 'pg'
require 'pry'

DB = PG.connect({dbname: 'news_curator_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM sources *;")
  end
end