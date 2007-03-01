class Select < SqlStatement
  class << self
    # call-seq: Select[arg,...] -> a_select
    # 
    # Returns a Select instance with the SQL initialized to 'select ' plus the args joined by ', '
    # 
    #    Select[1, :column1, 'book'].to_sql       #=> "select 1, column1, 'book'"
    def [](*columns)
      self.new("select #{columns.collect{ |column| column.to_sql }.join(', ')}")
    end
  end
  
  # call-seq: select.from -> a_select
  # 
  # Returns a Select instance with ' from ' appended to the SQL statement.
  # 
  #    Select[1, :column1, 'book'].from.to_sql       #=> "select 1, column1, 'book' from "
  def from
    @to_sql += " from "
    self
  end
  
  # call-seq: select[table,...] -> a_select
  # 
  # Returns a Select instance with the table names, joined by ', ' appended to the SQL statement.
  # 
  #    Select[1, :column1, 'book'].from[:table1, :table2].to_sql       #=> "select 1, column1, 'book' from table1, table2"
  def [](*table_names)
    @to_sql += table_names.collect{ |table| table.to_s }.sort.join(', ')
    self
  end
  
  # call-seq: select.order_by -> a_select
  # 
  # Returns a Select instance with the order arguments, joined by ', ' appended to the SQL statement.
  # 
  #    Select[1].from[:table1].order_by(:column1, :column2).to_sql       #=> "select 1 from table1 order by column1, column2"
  def order_by(*column)
    @to_sql << " order by #{column.to_sql}"
    self
  end
  
end