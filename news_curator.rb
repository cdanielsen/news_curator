require 'pg'
require 'pry'
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
    new_category
  when 'VS'
    view_sources_by_category
  when 'VC'
    view_categories_by_source
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
    Source.all.each { |source| puts "#{source.name.upcase} : #{source.url}" }
    any_key
    main
  else
    puts "Frowny face: You don't have any sources yet!"
    any_key
    main
  end
end

def list_categories
  if Category.all != []
    puts "Your categories:"
    Category.all.each { |category| puts "#{category.slant}" }
    any_key
    main
  else
    puts "Frowny face: You don't have any categories yet!"
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
  case gets.chomp.upcase
  when "A"
    new_source
  when "C"
    tag_source_with_category(Source.all.last)
  when "R"
    main
  else
    trippin
    main
  end
end

def new_category
  puts "What's the name of the new category? e.g. 'lefty' or 'fascist' or 'right-wing'"
  name = gets.chomp.downcase
  new_category = Category.new({slant: name})
  new_category.save
  puts "New category created!"
  sleep 2
  puts "Would you like to..."
  puts "[A] << Add another category"
  puts "[C] << Tag this category with a source"
  puts "[R] << Return to the main menu"
  case gets.chomp.upcase
  when "A"
    new_category
  when "C"
    tag_category_with_source(new_category)
  when "R"
    main
  else
    trippin
    main
  end
end

def tag_category_with_source category
  if Source.all != []
    puts "Here are your current sources:"
    Source.all.each_with_index { | source, i| puts "#{i + 1} #{source.name}"}
    puts "\nEnter which number you'd like to link to '#{category.slant}'"
    selection = gets.chomp.to_i - 1
    category.add_source(Source.all[selection])
    puts "#{Source.all[selection].name} now attached to #{category.slant}!"
    sleep 2
    puts "Would you like to..."
    puts "[A]  << Add another source to this category"
    puts "[NC] << Return to the new category menu"
    puts "[M]  << Return to the main menu"
    case gets.chomp.upcase
    when "A"
      tag_category_with_source(category)
    when "NC"
      new_category
    when "M"
      main
    else
      trippin
      main
    end
  else
    puts "Frowny face -- you don't have any categories yet!"
    sleep 2
    main
  end
end

def tag_source_with_category source
  if Category.all != []
    puts "Here are your current categories:"
    Category.all.each_with_index { |category, i| puts "#{i + 1} #{category.slant.upcase}"}
    puts "\nEnter which number you'd like to link to '#{source.name}'"
    selection = gets.chomp.to_i - 1
    source.add_category(Category.all[selection])
    puts "#{source.name} tagged with #{Category.all[selection].slant}!"
    sleep 2
    puts "Would you like to..."
    puts "[A]  << Add another category to this source"
    puts "[NS] << Return to the new source menu"
    puts "[M]  << Return to the main menu"
    case gets.chomp.upcase
    when "A"
      tag_source_with_category(source)
    when "NS"
      new_source
    when "M"
      main
    else
      trippin
      main
    end
  else
    puts "Frowny face -- you don't have any categories yet!"
    sleep 2
    main
  end
end

def view_sources_by_category
  if Category.all != []
    puts "Here are your current categories:"
    Category.all.each_with_index { |category, i| puts "#{i + 1} #{category.slant.upcase}"}
    puts "Which category would you like to see the associated sources for?"
    selection = gets.chomp.to_i - 1
    puts "\nThe sources associated with '#{Category.all[selection].slant.upcase}' are:"
    Category.all[selection].sources.each { | source | puts "#{source.name}" }
    any_key
    main
  else
    puts "Frowny face -- you don't have any categories yet!"
    sleep 2
    main
  end
end

def view_categories_by_source
  if Source.all != []
    puts "Here are your current sources:"
    Source.all.each_with_index { |source, i| puts "#{i + 1} #{source.name}"}
    puts "Which source would you like to see the associated categories for?"
    selection = gets.chomp.to_i - 1
    puts "\nThe categories associated with '#{Source.all[selection].name}' are:"
    Source.all[selection].categories.each { | category | puts "#{category.slant}" }
    any_key
    main
  else
    puts "Frowny face -- you don't have any sources yet!"
    sleep 2
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




