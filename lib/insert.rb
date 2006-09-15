class Insert < SqlStatement
  class << self
    def into
      self
    end
    
    def [](table)
      self.new("insert into #{table.to_sql}")
    end
  end
  
  def [](*columns)
    @to_sql += " (#{columns.join(', ')})"
    self
  end
  
  def values
    @to_sql += " #{yield.to_sql}"
    self
  end
end