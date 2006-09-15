class Select < SqlStatement
  class << self
    def [](*columns)
      self.new("select #{columns.collect{ |column| column.to_sql }.join(', ')}")
    end
  end
  
  def from
    @to_sql += " from "
    self
  end
  
  def [](*table_names)
    @to_sql += table_names.collect{ |table| table.to_s }.sort.join(', ')
    self
  end
  
end