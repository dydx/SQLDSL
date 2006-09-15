class Delete < SqlStatement
  class << self
    def from      
      self.new('delete from ')
    end
  end
  
  def [](table)
    @to_sql += table.to_sql
    self
  end
  
  def where(&block)
    @to_sql += WhereBuilder.new(&block).to_sql
    self
  end
end