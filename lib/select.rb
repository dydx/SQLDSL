class Select < SqlStatement
  class << self
    # call-seq: Select[arg,...] -> a_select
    # 
    # Returns a Select instance with the SQL initialized to 'select ' plus the args joined by ', '
    # 
    #    Select[1, :column1, 'book'].to_sql       #=> "select 1, column1, 'book'"
    def [](*columns)
      self.new("select #{columns.to_sql}")
    end
    
    # call-seq: Select.distinct -> a_select
    # 
    # Returns a Select class that appends 'distinct' to the select clause
    # 
    #    Select.distinct[1, :column1, 'book'].to_sql       #=> "select distinct 1, column1, 'book'"
    def distinct
      DistinctSelect
    end
    
    # call-seq: Select[arg,...] -> a_select
    # 
    # Returns a Select instance with the SQL initialized to 'select *'
    # 
    #    Select.all.to_sql       #=> "select *"
    def all
      self.new("select *")
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
    @tables = table_names.inject([]) { |result, element| result + (element.is_a?(Hash) ? element.values : [element]) }

    @to_sql += table_names.inject([]) do |result, element|
      result + (element.is_a?(Symbol) ? [element] : element.to_a.inject([]) { |result, pair| result << :"#{pair.first} #{pair.last}" })
    end.sort{ |x,y| x.to_s <=> y.to_s }.to_sql
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