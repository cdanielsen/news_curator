require 'source'
require 'category'

DB = PG.connect({dbname: 'news_curator'})

def main
  puts "Welcome to NewsCurator!"
  puts "What would you like to do?"
  puts "[LS] << List all your current sources"
  puts "[AS] << Add a source"
  puts "[LC] << List all your current categories"
  puts "[AC] << Add a category"
  puts "[VS] << View news sources by category"
  puts "[VC] << View the categories assigned to a source"
  case gets.chomp.upcase
  when 'LS'
    list_sources
  when 'AS'
    add_source
  when 'LC'
    list_categories
  when 'AC'
    add_category
  when 'VS'
    view_sources
  when 'VC'
    view_categories
  else
    trippin
  end
end

def trippin
  puts "That choice makes me... sad"
end

main




