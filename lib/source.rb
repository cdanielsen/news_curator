class Source

attr_reader :name, :url, :id

  def initialize attributes
  	@name = attributes[:name]
    @url = attributes[:url]
    @id = attributes[:id]
  end

  def self.all
    results = DB.exec('SELECT * FROM sources;')
    sources = []
    results.each do |result|
      name = result['name']
      url = result['url']
      id = result['id'].to_i
      sources << Source.new({name: name, url: url, id: id})
    end
    sources
  end

  def save
    result = DB.exec("INSERT INTO sources (name, url) VALUES ('#{@name}', '#{@url}') RETURNING id;")
    @id = result.first['id'].to_i
  end

  def ==(another_source)
    self.name == another_source.name && self.url == another_source.url
  end

  def add_category inbound_category
    DB.exec("INSERT INTO categorys_sources (category_id, source_id) VALUES ('#{inbound_category.id}','#{self.id}');")
  end

  def categories
    results = DB.exec("SELECT categorys.* FROM sources JOIN categorys_sources ON (sources.id = categorys_sources.source_id) JOIN categorys ON (categorys_sources.category_id = categorys.id) WHERE sources.id = #{self.id};")
    categorys = []
    results.each do |result|
      slant = result['slant']
      categorys << Category.new({slant: slant})
    end
    categorys
  end
end
