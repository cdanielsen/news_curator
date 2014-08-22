require 'pg'
require './lib/source'
require './lib/category'

DB = PG.connect({dbname: 'news_curator'})

def main
  system 'clear'
  puts "Welcome to NewsCurator!"
  puts "What would you like to do?"
  puts "[LS] << List all your current sources"
  puts "[AS] << Add a new source"
  puts "[LC] << List all your current categories"
  puts "[AC] << Add a new category"
  puts "[VS] << View news sources by category"
  puts "[VC] << View the categories assigned to a source"
  puts "[X]  << Exit"
  case gets.chomp.upcase
  when 'LS'
    list_sources
  when 'AS'
    new_source
  when 'LC'
    list_categories
  when 'AC'
    add_category
  when 'VS'
    view_sources
  when 'VC'
    view_categories
  when 'X'
    puts "See you next time!"
    sleep 2
  else
    trippin
    main
  end
end

def list_sources
  if Source.all != []
    puts "Your collection of news sources:"
    Source.all.sort.each { |source| puts "#{source.name.upcase} : #{source.url}"}
    any_key
    main
  else
    puts "You don't have any sources yet!"
    any_key
    main
  end
end

def new_source
  puts "What's the name of the source? e.g. The New York Times"
  name = gets.chomp.downcase
  puts "What's the url of the source? e.g. nytimes.com"
  url = gets.chomp.downcase
  new_source = Source.new({name: name, url: url})
  new_source.save
  puts "New source created!"
  sleep 2
  puts "Would you like to..."
  puts "[A] << Add another source"
  puts "[C] << Tag this source with a category"
  puts "[R] << Return to the main menu"
  case gets.chomp
  when "A"
    new_source
  when "C"
    add_category
  when "R"
    main
  else
    trippin
    main
  end
end

def trippin
  puts ")-X  I can't do that  X-("
  sleep 2
end

def any_key
  puts "\nPress any key to continue"
  gets
end

main




