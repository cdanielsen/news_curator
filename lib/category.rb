class Category

attr_reader :slant, :id

  def initialize attributes
    @slant = attributes[:slant]
    @id = attributes[:id]
  end

  def self.all
    results = DB.exec('SELECT * FROM categorys;')
    categorys = []
    results.each do |result|
      id = result['id'].to_i
      slant = result['slant']
      categorys << Category.new({id: id, slant: slant})
    end
    categorys
  end

  def save
    result = DB.exec("INSERT INTO categorys (slant) VALUES ('#{@slant}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def ==(another_category)
    self.slant == another_category.slant
  end

  def add_source inbound_source
    DB.exec("INSERT INTO categorys_sources (category_id, source_id) VALUES ('#{self.id}', '#{inbound_source.id}');")
  end

  def sources
    results = DB.exec("SELECT sources.* FROM categorys JOIN categorys_sources ON (categorys.id = categorys_sources.category_id) JOIN sources ON (categorys_sources.source_id = sources.id) WHERE categorys.id = #{self.id};")
    sources = []
    results.each do |result|
      name = result['name']
      url = result['url']
      sources << Source.new({name: name, url: url})
    end
    sources
  end
end
