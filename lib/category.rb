class Category

attr_reader :slant

  def initialize attributes
    @slant = attributes[:slant]
    @id = nil
  end

  def self.all
    results = DB.exec('SELECT * FROM categorys;')
    categorys = []
    results.each do |result|
      slant = result['slant']
      categorys << Category.new({slant: slant})
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

end
